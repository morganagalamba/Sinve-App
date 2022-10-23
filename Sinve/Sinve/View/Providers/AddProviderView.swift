//
//  AddProviderView.swift
//  Sinve
//
//  Created by alexdamascena on 22/10/22.
//

import UIKit



class AddProviderView: UIView {
    
    var delegate: AddProviderProtocol?

    var nameText: String = {
        return name.input.text ?? ""
    }

    var cnpjText: String = {
        return cnpj.input.text ?? ""
    }

    var phoneText: String = {
        return phone.input.text ?? ""
    }

    var timeToWait: Int = {
        return timeDelivery.timeDeliveryText
    }

    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 16
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let name: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder:"Ativa produtos diversificados",
                                        keyboard: .default, title: "Nome")
        input.configure(with: model)
        return input
    }()
    
    let cnpj: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "0000000000",
                                        keyboard: .numberPad, title: "CNPJ")
        input.configure(with: model)
        return input
    }()
    
    let phone: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder: "(81) 99999-9999",
                                        keyboard: .phonePad, title: "Telefone")
        input.configure(with: model)
        return input
    }()
    
    let timeDelivery = TimeDelivery()
    
    public let addProviderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar Fornecedor", for: .normal)
        button.configuration = UIButton.Configuration.filled()
        button.backgroundColor = UIColor(named: "BackGround")
        button.addTarget(nil, action: #selector(addProvider), for: .touchUpInside)
        return button
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
        addSubview(addProviderButton)
                
        mainStack.addArrangedSubview(name)
        mainStack.addArrangedSubview(cnpj)
        mainStack.addArrangedSubview(phone)
        mainStack.addArrangedSubview(timeDelivery)
    }
    
    private func setupConstraints(){
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1/2)
        ])
        
        addProviderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addProviderButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addProviderButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -64)
        ])
    }
    
    @objc func addProvider(){
        delegate?.didUserTapCreateProvider()
    }
}

