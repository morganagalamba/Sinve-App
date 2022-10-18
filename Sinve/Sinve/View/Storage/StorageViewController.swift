//
//  StorageViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 14/10/22.
//

import UIKit

class StorageViewController: UITableViewController {
    
    let searchBar:UISearchController = UISearchController()
    var estoque: [Estoque] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fillStorage()
        searchBar.searchResultsUpdater = self
        navigationItem.searchController =  searchBar
        tableView.register(StorageTableViewCell.self, forCellReuseIdentifier: StorageTableViewCell.identifier)
        view.backgroundColor = UIColor(named: "BackGround")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.title = "Estoque"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estoque.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorageTableViewCell.identifier, for: indexPath) as? StorageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.productName.text = estoque[indexPath.row].nome
        cell.quantidy.text = String(estoque[indexPath.row].quantidade)
        cell.quantidyIdeal.text = String(estoque[indexPath.row].estoqueIdeal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func fillStorage(){
        let url = URL(string: "https://sinve-back-production.up.railway.app/estoque-ideal")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let result = try? JSONDecoder().decode([Estoque].self, from: data!) {
                self.estoque = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Erro ao decodificar dados da API")
            }
            
        }
        task.resume()
    
    }

}

extension StorageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchBar.searchBar.text else {
            return
        }
        //usar text pra procurar
        self.tableView.reloadData()
    }
    
    
}
