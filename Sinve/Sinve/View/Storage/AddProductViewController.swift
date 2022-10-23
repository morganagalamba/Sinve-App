//
//  AddProductViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 19/10/22.
//

import UIKit

class AddProductViewController: UIViewController {
    
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
        
        fillProvider()
        
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
        //addProductView.delegate = self
        
        providerPickerView.delegate = self
        providerPickerView.tag = 2
        providerPickerView.backgroundColor = .white
        addProductView.provider.input.inputView = providerPickerView
        
       
    }
    
    func fillProvider() {
        let url = URL(string: "http://ec2-54-89-160-231.compute-1.amazonaws.com:5500/fornecedor")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let result = try? JSONDecoder().decode([Fornecedor].self, from: data!) {
                self.fornecedores = result
            } else {
                print("Erro ao decodificar dados da API")
            }
            
        }
        task.resume()
        
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
        let selected = items[row]
        
        addProductView.category.input.text = selected
    }
}
