//
//  AddProviderView.swift
//  Sinve
//
//  Created by alexdamascena on 22/10/22.
//

import UIKit

class AddProviderView: UIView {
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 22
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let name: TextInputSinve = {
        let input = TextInputSinve()
        let model = TextInputSinveModel(placeholder:"Ativa produtos diversificados",
                                        keyboard: .default)
        input.configure(with: model)
        return input
    }()
    
    
    let cnpj = TextInputSinve()
    let phone = TextInputSinve()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        addSubview(mainStack)
        
        let view4 = UIView()
        view4.backgroundColor = .green
        
        mainStack.addArrangedSubview(name)
        mainStack.addArrangedSubview(cnpj)
        mainStack.addArrangedSubview(phone)
        mainStack.addArrangedSubview(view4)
    }
    
    private func setupConstraints(){
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1/2)
        ])
    }
}
