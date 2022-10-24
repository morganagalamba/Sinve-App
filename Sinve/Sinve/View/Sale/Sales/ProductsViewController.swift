//
//  ProductsViewController.swift
//  Sinve
//
//  Created by sml on 23/10/22.
//

import UIKit

class ProductsViewController: UIViewController {
    private var sales: Sales?

    init(with sales: Sales){
         super.init(nibName: nil, bundle: nil)
         self.sales = sales
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var tableView: UITableView = {
        let tableViewAux = UITableView()
        tableViewAux.translatesAutoresizingMaskIntoConstraints = false
        return tableViewAux
    }()
    
    let stackVie: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    public var total: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Total:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var totalAmount: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
//        searchBar.searchResultsUpdater = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.identifier)

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "BackGround")
        tableView.showsVerticalScrollIndicator = false
//        navigationItem.searchController =  searchBar
        view.backgroundColor = UIColor(named: "BackGround")
        let dateAux = (sales?.date)!
        self.title = "\(dateAux.prefix(10).suffix(2))/\(dateAux.prefix(7).suffix(2))/\(dateAux.prefix(4)) \(dateAux.prefix(16).suffix(5))"
        
        var totalAmountAux = 0
        for product in (sales?.prod)! {
            totalAmountAux += product.price
        }
        self.totalAmount.text = "R$ \(String(totalAmountAux)),00"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)

        stackVie.addArrangedSubview(total)
        stackVie.addArrangedSubview(totalAmount)
        view.addSubview(stackVie)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: stackVie.topAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            stackVie.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            stackVie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackVie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackVie.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sales?.prod.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as? ProductsTableViewCell else {
            return UITableViewCell()
        }

        let card = (sales?.prod)![indexPath.row]
        cell.draw(card)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
