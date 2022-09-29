//
//  SaleTableViewCell.swift
//  Sinve
//
//  Created by Morgana Galamba on 29/09/22.
//

import UIKit

class SaleTableViewCell: UITableViewCell {
    
    static let identifier = "SaleTableViewCell"
    
    public let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let product: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let quantidy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(product)
        contentView.addSubview(price)
        contentView.addSubview(quantidy)
        
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
        
    }

}
