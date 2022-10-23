//
//  AddProductViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 19/10/22.
//

import UIKit

protocol AddProductProtocol: AnyObject {
    func didUserTapAddProduct();
    func emitFillAlert();
}

class AddProductViewController: UIViewController, AddProductProtocol {
 
    let addProductView = AddProductView()
    let pickerView = UIPickerView()
    let datePickerView = UIDatePicker()
    let providerPickerView = UIPickerView()
    let items = ["Caderno", "Jogos","Caneta","Variados"]
    var fornecedores: [Fornecedor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cadastrar Produto"
        self.view = addProductView
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "BackGround")
        
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.tag = 1
        addProductView.category.input.inputView = pickerView
        
        datePickerView.datePickerMode = .date
        datePickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        datePickerView.backgroundColor = .white
        datePickerView.contentVerticalAlignment = .center
        datePickerView.contentHorizontalAlignment = .center
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        addProductView.date.input.inputView = datePickerView
        addProductView.delegate = self
        
        providerPickerView.delegate = self
        providerPickerView.tag = 2
        providerPickerView.backgroundColor = .white
        addProductView.provider.input.inputView = providerPickerView
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            let providers = await fillProvider()
            self.fornecedores = providers
            print(providers.count)
        }
    }
    
    func fillProvider() async -> [Fornecedor] {
        let providerUrl = URL(string: "http://ec2-54-89-160-231.compute-1.amazonaws.com:5500/fornecedor")
        
        guard let url = providerUrl else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([Fornecedor].self, from: data)
            return result
        } catch {
            print("Erro ao decodificar dados da API")
            return []
        }
    }
    
}

extension AddProductViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        addProductView.date.input.text = selectedDate
        
        print("Selected value \(selectedDate)")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return items.count
        } else {
            return fornecedores.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return items[row]
        } else {
            return fornecedores[row].nomeFantasia
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            let selected = items[row]
            addProductView.category.input.text = selected
        } else {
            if fornecedores.count > 0 {
                let provider = fornecedores[row].nomeFantasia
                addProductView.provider.input.text = provider
                addProductView.fornecedor = fornecedores[row]
            }
            
        }    
    }
    
   func didUserTapAddProduct() {
       DispatchQueue.main.async {
           var view = didAddViewController()
           view.hidesBottomBarWhenPushed = true
           self.navigationController?.pushViewController(view, animated: true)
       }
    }
    
    func emitFillAlert() {
        var dialogMessage = UIAlertController(title: "Não foi possível cadastrar produto", message: "Preencha todos os campos!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
