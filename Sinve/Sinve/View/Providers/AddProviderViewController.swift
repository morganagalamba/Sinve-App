//
//  AddProviderViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 19/10/22.
//

import UIKit

protocol AddProviderProtocol: AnyObject {
    func didUserTapCreateProvider() async
}

class AddProviderViewController: UIViewController {
    
    let addProviderView = AddProviderView()
    let pickerView = UIPickerView()
    let items = ["Dias", "Meses"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addProviderView
        self.title = "Cadastrar Fornecedor"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "BackGround")
        pickerView.delegate = self
        addProviderView.delegate = self
        addProviderView.timeDelivery.typeInput.inputView = pickerView // matei as boas praticas, cansado dms para fazer um delegate
        dismissPickerView()
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
        addProviderView.timeDelivery.typeInput.inputAccessoryView = toolBar
        // matei as boas praticas, cansado dms para fazer um delegate
    }
    
    @objc func action() {
          view.endEditing(true)
    }
}


extension AddProviderViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = items[row]
        addProviderView.timeDelivery.typeInput.text = selected
        // matei as boas praticas, cansado dms para fazer um delegate
    }
}

extension AddProviderViewController: AddProviderProtocol {

    struct Constants {
        static let PROVIDER_URL = "http://ec2-54-89-160-231.compute-1.amazonaws.com:5500/fornecedor"
        static let PROVIDER_REQUEST = "POST"
    }
    
    func didUserTapCreateProvider() async {
        let fornecedor = addProviderView.getProviderInputs()

        let parameters: [String: Any] = [
            "nomeFantasia": fornecedor.nomeFantasia,
            "prazoEntrega": fornecedor.prazoEntrega,
            "telefone": fornecedor.telefone,
            "CNPJ": fornecedor.cnpj
        ]

        guard let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        guard let url = URL(string: Constants.PROVIDER_URL) else { return }
        var request = URLRequest(url: url)

        request.httpMethod = Constants.PROVIDER_REQUEST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        do {
            let (_, _ ) = try await URLSession.shared.data(for: request)
        } catch {
            print(error)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
