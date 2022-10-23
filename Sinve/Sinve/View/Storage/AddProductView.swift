//
//  AddProductView.swift
//  Sinve
//
//  Created by Morgana Galamba on 22/10/22.
//

import UIKit

class AddProductView: UIView {
    
    public var fornecedor: Fornecedor?
    var delegate: AddProductProtocol?
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 16
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let code: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder:"00987673822",
                                        keyboard: .numberPad, title: "Código do produto")
        input.configure(with: model)
        return input
    }()
    
    let name: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "Skipbo jogo de cartas",
                                        keyboard: .default, title: "Nome do produto")
        input.configure(with: model)
        return input
    }()
    
    //setar p caixa
    let amount: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "25",
                                        keyboard: .numberPad, title: "Quantidade")
        input.configure(with: model)
        return input
    }()
    
    let price: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "10",
                                        keyboard: .numberPad, title: "Preço por unidade ")
        input.configure(with: model)
        return input
    }()
    
    let category: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "Jogos",
                                        keyboard: .numberPad, title: "Categoria")
        input.configure(with: model)
        return input
    }()
       
    public let addProductButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.configuration = UIButton.Configuration.filled()
        button.backgroundColor = UIColor(named: "BackGround")
        button.addTarget(nil, action: #selector(addProduct), for: .touchUpInside)
        return button
    }()
    
    let date: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "00/00/00",
                                        keyboard: .numbersAndPunctuation, title: "Data de validade")
        input.configure(with: model)
        return input
    }()
    
    let provider: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "Empresa", keyboard: .numberPad, title: "Fornecedor")
        input.configure(with: model)
        return input
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        addSubview(mainStack)
        addSubview(addProductButton)
                
        mainStack.addArrangedSubview(code)
        mainStack.addArrangedSubview(name)
        mainStack.addArrangedSubview(amount)
        mainStack.addArrangedSubview(price)
        mainStack.addArrangedSubview(category)
        mainStack.addArrangedSubview(date)
        mainStack.addArrangedSubview(provider)
        //mainStack.addArrangedSubview(timeDelivery)
    }
    
    private func setupConstraints(){
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -130)
        ])
        
        addProductButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addProductButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addProductButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -64)
        ])
    }
    
    @objc func addProduct(){
        let baseURl = "https://sinve-back-production.up.railway.app/"
        let path = "cadastro-de-produto"
        
        var quantidade = 0
        var preco = 0
        if let amount = self.amount.input.text, let price = self.price.input.text {
            quantidade = Int(amount) ?? 0
            preco = Int(price) ?? 0
        }
   
        let parametros: [String: Any] = [
            "produto": [
                "nome": self.name.input.text ,
                "codigo": self.code.input.text,
                "categoria": self.category.input.text,
                "dataValidade": self.date.input.text,
                "quantidade": quantidade,
                "precoPorUnidade": preco,
                    
            ],
            "fornecedor": [
                "CNPJ": fornecedor?.cnpj,
                "nomeFantasia": fornecedor?.nomeFantasia,
                "prazoEntrega": fornecedor?.prazoEntrega,
                "telefone": fornecedor?.telefone
            ]
        ]
        
        guard let body = try? JSONSerialization.data(withJSONObject: parametros, options: []) else { return }
        
        guard let url = URL(string: baseURl + path) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    self.delegate?.didUserTapAddProduct()
                    
                } catch {
                   print(error)
                }
            }
        }.resume()
    }
    
    let slash = "/"
    let digits = CharacterSet(charactersIn: "0123456789")

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        //Deleting
        if string.count == 0 {
            var text = textField.text!
            let start = text.startIndex
            let beginRange = text.index(start, offsetBy: range.location)
            let endRange = text.index(start, offsetBy: range.location + range.length)
            text = String(text.prefix(upTo: beginRange))
                + String(text.suffix(from: endRange))
            text = text.replacingOccurrences(of: "/", with: "")
            if text.count >= 3 {
                text = String(text.prefix(2)) + "/" + String(text.dropFirst(2))
            }

            textField.text = text

            return false
        }

        //Typing

        let count = textField.text!.count
        guard string.count == 1,
            count < 6,
            let scalar = Character(string).unicodeScalars.first else {
                return false
        }

        let isDigit = digits.contains(scalar)

        switch count {
        case 0, 3..<6 :
            return isDigit
        case 1:
            if isDigit {
                textField.text = textField.text! + string + "/"
            }
            return false
        case 2:
            if string == slash {
                return true
            } else {
                textField.text = textField.text! + "/" + string
                return false
            }
        default:
            return false
        }
    }
}
