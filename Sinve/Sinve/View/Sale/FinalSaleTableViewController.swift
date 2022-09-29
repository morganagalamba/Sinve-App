//
//  FinalSaleTableViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 28/09/22.
//

import UIKit

class FinalSaleTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SaleTableViewCell.self, forCellReuseIdentifier: SaleTableViewCell.identifier)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
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
        
        //configurar cell
        cell.product.text = ""
        cell.quantidy.text = "" + "x"
        cell.price.text = "R$" + ""

        return cell
    }
    
}
