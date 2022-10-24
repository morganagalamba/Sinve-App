//
//  SaleViewController+TableView.swift
//  Sinve
//
//  Created by sml on 23/10/22.
//

import UIKit

extension SaleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SalesTableViewCell.identifier, for: indexPath) as? SalesTableViewCell else {
            return UITableViewCell()
        }

        let card = sales[indexPath.row]
        cell.draw(card)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
            let card = ProductsViewController(with: sales[indexPath.item])
            navigationController?.pushViewController(card, animated: false)
       }
}
