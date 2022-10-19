//
//  ProviderTableViewCell.swift
//  Sinve
//
//  Created by Morgana Galamba on 18/10/22.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {

    static let identifier = "ProviderTableViewCell"
    var number = ""
    
    public let call: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        let symbol = UIImage(systemName: "phone.fill.arrow.up.right", withConfiguration: config)?.withTintColor(UIColor(named:"PineTree") ?? .white)
        button.setImage(symbol, for: .normal)
        button.backgroundColor = UIColor(named: "LaurelGreen")
        button.layer.cornerRadius = 13
        button.addTarget(self, action:#selector(pressed), for: .touchUpInside)
        return button
    }()

    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var name: UILabel = {
        let label = UILabel()
        label.text = "Nome"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var company: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var cnpj: UILabel = {
        let label = UILabel()
        label.text = "CNPJ"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var cnpjNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var deliver: UILabel = {
        let label = UILabel()
        label.text = "Prazo de entrega"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let daysView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackGround")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var days: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = UIColor(named: "BackGround")
        contentView.addSubview(cellView)
        contentView.addSubview(name)
        contentView.addSubview(company)
        contentView.addSubview(cnpj)
        contentView.addSubview(cnpjNumber)
        contentView.addSubview(deliver)
        contentView.addSubview(daysView)
        contentView.addSubview(days)
        contentView.addSubview(call)
        
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            company.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            company.widthAnchor.constraint(equalToConstant: contentView.bounds.width/2 - 4),
            company.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 6),
        ])
        
        NSLayoutConstraint.activate([
            cnpj.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            cnpj.topAnchor.constraint(equalTo: company.bottomAnchor,constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            cnpjNumber.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            cnpjNumber.topAnchor.constraint(equalTo: cnpj.bottomAnchor ,constant: 6),
        ])
        
        NSLayoutConstraint.activate([
            deliver.leadingAnchor.constraint(equalTo: company.trailingAnchor),
            deliver.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            daysView.leadingAnchor.constraint(equalTo: deliver.leadingAnchor),
            daysView.topAnchor.constraint(equalTo: deliver.bottomAnchor,constant: 8),
            daysView.widthAnchor.constraint(equalToConstant: 66),
            daysView.heightAnchor.constraint(equalToConstant: 31)
        ])
        
        NSLayoutConstraint.activate([
            days.centerYAnchor.constraint(equalTo: daysView.centerYAnchor),
            days.centerXAnchor.constraint(equalTo: daysView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            call.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            call.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,constant: -20),
            call.widthAnchor.constraint(equalToConstant: 26),
            call.heightAnchor.constraint(equalToConstant: 26)
        ])
      
    }
    
    @objc func pressed() {
        let formattedString = number.replacingOccurrences(of: " ", with: "")
        guard let number = URL(string: "tel://" + formattedString) else { return }
            UIApplication.shared.open(number)
    }

}
