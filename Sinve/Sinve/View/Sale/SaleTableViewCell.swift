//
//  SaleTableViewCell.swift
//  Sinve
//
//  Created by Morgana Galamba on 29/09/22.
//

import UIKit

class SaleTableViewCell: UITableViewCell {
    
    static let identifier = "SaleTableViewCell"
    
    public var price: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "R$0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var product: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "borracha"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var quantidy: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "2x"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: "BackGround")
        
        contentView.addSubview(quantidy)
        contentView.addSubview(product)
        contentView.addSubview(price)
        
        
        setupConstraints()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            quantidy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            quantidy.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            quantidy.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            product.leadingAnchor.constraint(equalTo: quantidy.trailingAnchor, constant: 16),
            product.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            product.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            price.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }

}
