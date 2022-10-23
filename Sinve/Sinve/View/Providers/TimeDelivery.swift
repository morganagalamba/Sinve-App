//
//  TimeDelivery.swift
//  Sinve
//
//  Created by alexdamascena on 22/10/22.
//

import UIKit

class TimeDelivery: UIView {

    let timeDeliveryText: Int = {
        let isMonth = typeInput.text == "Dias" ? false : true
        if isMonth {
            return 30 * Int(input.text)
        }
        return Int(input.text)
    }
    
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
        label.text = "Prazo de entrega"
        return label
    }()
    
    let daysAndTypeView = UIView()
    
    let daysStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 22
        stack.distribution = .fillEqually
        return stack
    }()
    
    let input: TextField = {
        let text = TextField()
        text.font = UIFont.systemFont(ofSize: 17)
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.textColor = UIColor(named: "inputTextColor")
        text.backgroundColor = UIColor(named: "inputColor")
        text.placeholder = "10"
        return text
    }()
    
    let typeInput: TextField = {
        let text = TextField()
        text.font = UIFont.systemFont(ofSize: 17)
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.textColor = UIColor(named: "inputTextColor")
        text.backgroundColor = UIColor(named: "inputColor")
        text.text = "Dias"
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
        mainStack.addArrangedSubview(daysAndTypeView)
        
        daysAndTypeView.addSubview(daysStack)
        daysStack.addArrangedSubview(input)
        daysStack.addArrangedSubview(typeInput)
    }
    
    private func setupConstraints(){
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        daysStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysStack.topAnchor.constraint(equalTo: daysAndTypeView.topAnchor),
            daysStack.leadingAnchor.constraint(equalTo: daysAndTypeView.leadingAnchor),
            daysStack.trailingAnchor.constraint(equalTo: daysAndTypeView.trailingAnchor),
            daysStack.bottomAnchor.constraint(equalTo: daysAndTypeView.bottomAnchor)
        ])
        
    }
}
