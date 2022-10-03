//
//  TotalView.swift
//  Sinve
//
//  Created by Morgana Galamba on 03/10/22.
//

import UIKit

class TotalView: UITableViewHeaderFooterView {
    
    public var total: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var price: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.backgroundColor = UIColor(named: "DarkSeaGreen")
        
        contentView.addSubview(total)
        contentView.addSubview(price)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            total.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            total.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            total.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            price.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
    }
}
