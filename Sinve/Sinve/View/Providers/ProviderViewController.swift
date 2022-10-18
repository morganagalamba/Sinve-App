//
//  ProfileViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 26/09/22.
//

import UIKit

class ProviderViewController: UITableViewController {
    
    let searchBar:UISearchController = UISearchController()
    var fornecedores: [Fornecedor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fillProvider()
        searchBar.searchResultsUpdater = self
        navigationItem.searchController =  searchBar
        tableView.register(ProviderTableViewCell.self, forCellReuseIdentifier: ProviderTableViewCell.identifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.backgroundColor = UIColor(named: "BackGround")
        self.title = "Fornecedores"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fornecedores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProviderTableViewCell.identifier, for: indexPath) as? ProviderTableViewCell else {
            return UITableViewCell()
        }
        
        cell.company.text = fornecedores[indexPath.row].nomeFantasia
        cell.cnpjNumber.text = fornecedores[indexPath.row].cnpj
        cell.days.text = String(fornecedores[indexPath.row].prazoEntrega) + " dias"
        
//        cell.company.text = "Ativa produtos veterinários"
//        cell.cnpjNumber.text = "0918138319/001"
//        cell.days.text = "30 dias"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func fillProvider(){
        let url = URL(string: "http://ec2-54-89-160-231.compute-1.amazonaws.com:5500/fornecedor")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            let decoder = JSONDecoder()
            if let data = data {
                
                do {
                    let result = try decoder.decode([Fornecedor].self, from: data)
                    self.fornecedores = result
                    print(result)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Erro ao decodificar dados da API")
                }
            }
            
        }
        task.resume()
    
    }

}


extension ProviderViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchBar.searchBar.text else {
            return
        }
        //usar text pra procurar
        self.tableView.reloadData()
    }

}
