//
//  FinalSaleTableViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 28/09/22.
//

import UIKit

class FinalSaleTableViewController: UITableViewController {
    
    var productsCount: [String : Int]
    var produtos: [Produto] = []
    
    init(productsCount: [String : Int], produtos: [Produto]) {
        self.productsCount = productsCount
        self.produtos = produtos
        super.init(nibName: nil, bundle: nil)    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SaleTableViewCell.self, forCellReuseIdentifier: SaleTableViewCell.identifier)
        tableView.register(TotalView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
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
        return produtos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaleTableViewCell.identifier, for: indexPath) as? SaleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "TimberWolf")
        let productBarcode = Array(productsCount.keys)
        let quantidy = Array(productsCount.values)
        
        cell.product.text = produtos[indexPath.row].nome
        cell.quantidy.text = String(quantidy[indexPath.row]) + "x"
        let price = getPrice(prod: produtos[indexPath.row].precoPorUnidade ?? 0)
        cell.price.text = price

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TotalView
        view.total.text = "Valor total: "
        view.price.text = "R" + getTotalPrice(prods: "")
        
        return view
    }
    
    func getPrice(prod: Int) -> String{
        let price = NumberFormatter.localizedString(from: Float(prod) as NSNumber, number: .currency)
        return price
    }
    
    func getTotalPrice(prods: String) -> String{
        let price = NumberFormatter.localizedString(from: 0.00, number: .currency)
        return price
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
