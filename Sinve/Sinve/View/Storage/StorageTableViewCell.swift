//
//  StorageTableViewCell.swift
//  Sinve
//
//  Created by Morgana Galamba on 18/10/22.
//

import UIKit

class StorageTableViewCell: UITableViewCell {
    
    static let identifier = "StorageTableViewCell"
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let quantidyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackGround")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let quantidyIdealView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackGround")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var productLabel: UILabel = {
        let label = UILabel()
        label.text = "Produto"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var quantidy: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var quantidyIdeal: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var quantidyLabel: UILabel = {
        let label = UILabel()
        label.text = "Em estoque"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var quantidyIdealLabel: UILabel = {
        let label = UILabel()
        label.text = "Estoque ideal"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = UIColor(named: "BackGround")
        contentView.addSubview(cellView)
        contentView.addSubview(productLabel)
        contentView.addSubview(productName)
        contentView.addSubview(quantidyView)
        contentView.addSubview(quantidyIdealView)
        contentView.addSubview(quantidyLabel)
        contentView.addSubview(quantidy)
        contentView.addSubview(quantidyIdealLabel)
        contentView.addSubview(quantidyIdeal)
        
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
            productLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            productLabel.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            productName.leadingAnchor.constraint(equalTo: productLabel.leadingAnchor),
            productName.widthAnchor.constraint(equalToConstant: contentView.bounds.width/2),
            productName.topAnchor.constraint(equalTo: productLabel.bottomAnchor,constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            quantidyLabel.leadingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: 8),
            quantidyLabel.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            quantidyView.leadingAnchor.constraint(equalTo: quantidyLabel.leadingAnchor),
            quantidyView.topAnchor.constraint(equalTo: quantidyLabel.bottomAnchor ,constant: 8),
            quantidyView.widthAnchor.constraint(equalToConstant: 66),
            quantidyView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            quantidy.centerXAnchor.constraint(equalTo: quantidyView.centerXAnchor),
            quantidy.centerYAnchor.constraint(equalTo:quantidyView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            quantidyIdealLabel.leadingAnchor.constraint(equalTo: quantidyLabel.trailingAnchor, constant: 30),
            quantidyIdealLabel.topAnchor.constraint(equalTo: quantidyLabel.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            quantidyIdealView.leadingAnchor.constraint(equalTo: quantidyIdealLabel.leadingAnchor),
            quantidyIdealView.topAnchor.constraint(equalTo: quantidyIdealLabel.bottomAnchor,constant: 8),
            quantidyIdealView.widthAnchor.constraint(equalToConstant: 66),
            quantidyIdealView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            quantidyIdeal.centerXAnchor.constraint(equalTo: quantidyIdealView.centerXAnchor),
            quantidyIdeal.centerYAnchor.constraint(equalTo: quantidyIdealView.centerYAnchor)
        ])
      
    }

}
