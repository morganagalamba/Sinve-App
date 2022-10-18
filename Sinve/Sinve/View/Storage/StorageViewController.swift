//
//  StorageViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 14/10/22.
//

import UIKit

class StorageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(StorageTableViewCell.self, forCellReuseIdentifier: StorageTableViewCell.identifier)
        view.backgroundColor = UIColor(named: "BackGround")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.title = "Estoque"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorageTableViewCell.identifier, for: indexPath) as? StorageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.productName.text = "Caderno tilibra Minnie 80"
        cell.quantidy.text = "50"
        cell.quantidyIdeal.text = "30"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
