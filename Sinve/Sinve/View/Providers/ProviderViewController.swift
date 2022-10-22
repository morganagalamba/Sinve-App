//
//  ProfileViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 26/09/22.
//

import UIKit

class ProviderViewController: UIViewController {
    
    let searchBar: UISearchController = UISearchController()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProviderTableViewCell.self, forCellReuseIdentifier: ProviderTableViewCell.identifier)
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor(named: "BackGround")
        return table
    }()
    
    var fornecedores: [Fornecedor] = []
    
    public let addProvider: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar Fornecedor", for: .normal)
        button.configuration = UIButton.Configuration.filled()
        button.backgroundColor = UIColor(named: "BackGround")
        button.addTarget(self, action:#selector(addProv), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        searchBar.searchResultsUpdater = self
        navigationItem.searchController =  searchBar
        tableView.dataSource = self
        tableView.delegate = self

        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "BackGround")
        self.title = "Fornecedores"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            let providers = await fillProvider()
            self.fornecedores = providers
            self.tableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addSubview(tableView)
        view.addSubview(addProvider)
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -85),
            
            addProvider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addProvider.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32)
        ])
    }
    
    func fillProvider() async -> [Fornecedor] {
        let providerUrl = URL(string: "http://ec2-54-89-160-231.compute-1.amazonaws.com:5500/fornecedor")
        
        guard let url = providerUrl else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([Fornecedor].self, from: data)
            return result
        } catch {
            print("Erro ao decodificar dados da API")
            return []
        }
        
    }
    
    @objc func addProv(){
        let view = AddProviderViewController()
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }

}

extension ProviderViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let _ = searchBar.searchBar.text else {
            return
        }
        //usar text pra procurar
        self.tableView.reloadData()
    }
}

extension ProviderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fornecedores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProviderTableViewCell.identifier, for: indexPath) as? ProviderTableViewCell else {
            return UITableViewCell()
        }
        
        cell.company.text = fornecedores[indexPath.row].nomeFantasia
        cell.cnpjNumber.text = fornecedores[indexPath.row].cnpj
        cell.days.text = String(fornecedores[indexPath.row].prazoEntrega) + " dias"
        cell.number = fornecedores[indexPath.row].telefone
        
        return cell
    }
    
}
