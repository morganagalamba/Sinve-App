//
//  SaleViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 28/09/22.
//

import UIKit

class SaleViewController: UIViewController {
    let searchBar:UISearchController = UISearchController()
    var sales: [Sales] = []
    
    public var tableView: UITableView = {
        let tableViewAux = UITableView()
        tableViewAux.translatesAutoresizingMaskIntoConstraints = false
        return tableViewAux
    }()

    public var lastSales: UILabel = {
        let label = UILabel()
        label.text = "Últimas Vendas"
        label.textColor = UIColor(named: "PineTree")
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public let addSale: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Nova venda", for: .normal)
        button.configuration = UIButton.Configuration.filled()
        button.backgroundColor = UIColor(named: "BackGround")
        button.addTarget(self, action:#selector(pressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillProvider()
        searchBar.searchResultsUpdater = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false

        tableView.register(SalesTableViewCell.self, forCellReuseIdentifier: SalesTableViewCell.identifier)

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "BackGround")
        navigationItem.searchController =  searchBar
        view.backgroundColor = UIColor(named: "BackGround")
        self.title = "Vendas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(lastSales)
        view.addSubview(tableView)
        view.addSubview(addSale)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([

            lastSales.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lastSales.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: lastSales.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: addSale.topAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            addSale.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addSale.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func pressed() {
        var view = ScannerViewController()
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func fillProvider(){
        let url = URL(string: "http://ec2-54-89-160-231.compute-1.amazonaws.com:5500/historico-vendas")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let result = try decoder.decode([Sales].self, from: data)
                    self.sales = result
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

extension SaleViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchBar.searchBar.text else {
            return
        }
        //usar text pra procurar
        self.tableView.reloadData()

    }

}
