//
//  FinalSaleTableViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 28/09/22.
//

import UIKit

class FinalSaleTableViewController: UITableViewController {
    
    var productsCount: [String : Int]
    
    init(productsCount: [String : Int]) {
        self.productsCount = productsCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SaleTableViewCell.self, forCellReuseIdentifier: SaleTableViewCell.identifier)
        self.title = "Carrinho"
        view.backgroundColor = UIColor(named: "BackGround")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productsCount.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaleTableViewCell.identifier, for: indexPath) as? SaleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let productBarcode = Array(productsCount.keys)
        let quantidy = Array(productsCount.values)
        
        cell.product.text = productBarcode[indexPath.row]
        cell.quantidy.text = String(quantidy[indexPath.row]) + "x"
        cell.price.text = "R$" + "2,00"

        return cell
    }
    
}
