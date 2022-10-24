//
//  SalesTableViewCell.swift
//  Sinve
//
//  Created by sml on 23/10/22.
//

import UIKit

class SalesTableViewCell: UITableViewCell {
    
    static let identifier = "SalesTableViewCell"
    
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
    
    public var date: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var total: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: "BackGround")
        
        stackVie.addArrangedSubview(date)
        stackVie.addArrangedSubview(total)
        
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
    
    func draw(_ cell: Sales){
        let dateAux = cell.date
        self.date.text = "\(dateAux.prefix(10).suffix(2))/\(dateAux.prefix(7).suffix(2))/\(dateAux.prefix(4)) \(dateAux.prefix(16).suffix(5))"
        var totalAmount = 0
        for product in cell.prod {
            totalAmount += product.price
        }
        self.total.text = "R$ \(String(totalAmount)),00"
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
