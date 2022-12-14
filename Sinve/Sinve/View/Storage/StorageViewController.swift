//
//  StorageViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 14/10/22.
//

import UIKit
import UserNotifications


class StorageViewController: UITableViewController {
    
    let searchBar:UISearchController = UISearchController()
    var estoque: [Estoque] = [] {
        didSet {
            self.notificateWhichProductNeedCare()
        }
    }
    var helperEstoque: [Estoque] = []
    var submitButton = UIButton()
    
    public var addProduct: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar Produto", for: .normal)
        button.configuration = UIButton.Configuration.filled()
        button.backgroundColor = UIColor(named: "BackGround")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchResultsUpdater = self
        navigationItem.searchController =  searchBar
        tableView.register(StorageTableViewCell.self, forCellReuseIdentifier: StorageTableViewCell.identifier)
        view.backgroundColor = UIColor(named: "BackGround")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.title = "Estoque"
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [
            .alert, .sound, .badge
        ]) { success, _ in
            guard success else { return }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.window?.addSubview(addProduct)
        addProduct.addTarget(self, action:#selector(addProd(_:)), for: .touchUpInside)
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.addProduct.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillStorage()
    }
        
    func setupConstraints(){
        addProduct.bottomAnchor.constraint(equalTo: view.window?.bottomAnchor ?? view.bottomAnchor, constant: -100).isActive = true
        addProduct.centerXAnchor.constraint(equalTo: view.window?.centerXAnchor ?? view.centerXAnchor).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helperEstoque.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorageTableViewCell.identifier, for: indexPath) as? StorageTableViewCell else {
            return UITableViewCell()
        }
        
        let idealQuantidy = helperEstoque[indexPath.row].estoqueIdeal
        let quantidy = helperEstoque[indexPath.row].quantidade
        cell.quantidy.text = String(quantidy)
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 10 , weight: .bold, scale: .small)
        let fullString = NSMutableAttributedString(string: String(quantidy) + "  ")
        
        if quantidy > idealQuantidy {
            cell.quantidyView.backgroundColor = UIColor(named: "lilac")

            let symbol = UIImage(systemName: "arrowtriangle.up.fill", withConfiguration: symbolConfig)
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = symbol
            fullString.append(NSAttributedString(attachment: imageAttachment))
            cell.quantidy.attributedText = fullString
            
        } else if quantidy < idealQuantidy {
            cell.quantidyView.backgroundColor = UIColor(named: "blue")
            
            let symbol = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: symbolConfig)
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = symbol
            fullString.append(NSAttributedString(attachment: imageAttachment))
            cell.quantidy.attributedText = fullString
        }
        
        cell.productName.text = helperEstoque[indexPath.row].nome
        
        cell.quantidyIdeal.text = String(idealQuantidy)
        
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
                self.helperEstoque = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Erro ao decodificar dados da API")
            }
            
        }
        task.resume()
    }
    
    @objc func addProd(_ sender : UIButton) {
        let view = AddProductViewController()
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    private func notificateWhichProductNeedCare(){
        let productsToCare = estoque.filter{ currEstoque in
            return currEstoque.quantidade - currEstoque.estoqueIdeal <= 0
        }
        
        productsToCare.forEach{ productToCare in
            let content = UNMutableNotificationContent()
            content.title = "Aten????o, estoque minimo!"
            content.body = "O produto \(productToCare.nome) est?? com estoque abaixo. Solicite \(productToCare.estoqueIdeal) produto ao fornecedor."
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)
        
            
            UNUserNotificationCenter.current().add(request)
        }
    }
}

extension StorageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchBar.searchBar.text else { return }
        
        let newEstoque = estoque.filter { estoq in
            return estoq.nome.hasPrefix(text)
        }
        
        self.helperEstoque = newEstoque
        self.tableView.reloadData()
    }
}

extension StorageViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.banner, .list, .badge])
    }
}
