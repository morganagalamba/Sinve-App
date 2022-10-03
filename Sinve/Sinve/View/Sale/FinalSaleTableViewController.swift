//
//  FinalSaleTableViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 28/09/22.
//

import UIKit

class FinalSaleTableViewController: UITableViewController {
    
    var productsCount = 0
    let scannerViewController = ScannerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SaleTableViewCell.self, forCellReuseIdentifier: SaleTableViewCell.identifier)
        scannerViewController.delegate = self
        view.backgroundColor = UIColor(named: "BackGround")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaleTableViewCell.identifier, for: indexPath) as? SaleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.product.text = "coco"
        cell.quantidy.text = "2" + "x"
        cell.price.text = "R$" + "2,00"

        return cell
    }
    
}


extension FinalSaleTableViewController: ScannerViewDelegate {
    func didFindScannedText(text: String) {
        productsCount += 1
    }
}
