//
//  TextInputSinve.swift
//  Sinve
//
//  Created by alexdamascena on 22/10/22.
//

import UIKit


struct TextInputSinveModel {
    let placeholder: String
    let keyboard: UIKeyboardType
}

class TextInputSinve: UIView {
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.text = "Nome"
        return label
    }()
    
    let input: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 17)
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.textColor = UIColor(named: "inputTextColor")
        text.backgroundColor = UIColor(named: "inputColor")
        return text
    }()

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
        mainStack.addArrangedSubview(name)
        mainStack.addArrangedSubview(input)
    }
    
    private func setupConstraints(){
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension TextInputSinve {
    
    func configure(with model: TextInputSinveModel){
        input.keyboardType = model.keyboard
        input.placeholder = model.placeholder
    }
}
