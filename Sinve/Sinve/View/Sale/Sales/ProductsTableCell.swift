//
//  ProductsTableCell.swift
//  Sinve
//
//  Created by sml on 23/10/22.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    static let identifier = "ProductsTableViewCell"
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackVie: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public var quantity: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var price: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: "BackGround")
        
        stackVie.addArrangedSubview(quantity)
        stackVie.addArrangedSubview(name)
        stackVie.addArrangedSubview(price)

        cellView.addSubview(stackVie)

        contentView.addSubview(cellView)

        setupConstraints()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func draw(_ cell: Products){
        self.price.text = "\(cell.price)"
        self.name.text = cell.name
        self.quantity.text = "x \(cell.quantity)"
    }
    
    private func setupConstraints(){

        NSLayoutConstraint.activate([
            stackVie.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            stackVie.topAnchor.constraint(equalTo: cellView.topAnchor),
            stackVie.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            stackVie.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
 
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

}
