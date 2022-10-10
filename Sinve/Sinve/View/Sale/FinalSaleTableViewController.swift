//
//  FinalSaleTableViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 28/09/22.
//

import UIKit

class FinalSaleTableViewController: UITableViewController {
    
    var productsCount: [String : Int]
    var produtos: [Produto] = []
    
    public let finalize: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.setTitle("Finalizar compra", for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action:#selector(finalizeSale), for: .touchUpInside)
        return button
    }()
    
    init(productsCount: [String : Int], produtos: [Produto]) {
        self.productsCount = productsCount
        self.produtos = produtos
        super.init(nibName: nil, bundle: nil)    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SaleTableViewCell.self, forCellReuseIdentifier: SaleTableViewCell.identifier)
        tableView.register(TotalView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.title = "Carrinho"
        view.backgroundColor = UIColor(named: "BackGround")
        view.addSubview(finalize)
        setupConstraints()
    }
    
    private func setupConstraints(){
        finalize.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 750).isActive = true
        finalize.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return produtos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaleTableViewCell.identifier, for: indexPath) as? SaleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "TimberWolf")
        
        if let name = produtos[indexPath.row].nome{
            if let quantidy = productsCount[name] {
                cell.quantidy.text = "\(quantidy)x"
            }
            cell.product.text = name
        }
        if let price = produtos[indexPath.row].precoPorUnidade {
            cell.price.text = getPrice(prod: price)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TotalView
        view.total.text = "Valor total: "
        view.price.text = getTotalPrice()
        return view
    }
    
    func getPrice(prod: Int) -> String{
        let price = NumberFormatter.localizedString(from: Float(prod) as NSNumber, number: .currency)
        return price
    }
    
    func getTotalPrice() -> String{
        var totalPrice = 0
        for produto in produtos{
            if let name = produto.nome{
                if let quantidy = productsCount[name] {
                    if let price = produto.precoPorUnidade {
                        totalPrice = totalPrice + price*quantidy
                    }
                }
            }
        }
        let price = NumberFormatter.localizedString(from: Float(totalPrice) as NSNumber , number: .currency)
        
        return price
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func finalizeSale() {
        post()
        var view = PaymentViewController()
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func post(){
        let baseURl = "https://sinve-back-production.up.railway.app/"
        let path = "registro-de-venda"
        
        for produto in produtos{
            if let name = produto.nome{
                if let quantidy = productsCount[name] {
                    let produto = Venda(nome: name , quantidade: Int32(quantidy))
                    
                    let parametros: [String: Any] = [
                        "nome": produto.nome,
                        "quantidade": produto.quantidade
                    ]
                    
                    guard let body = try? JSONSerialization.data(withJSONObject: parametros, options: []) else { return }
                    
                    guard let url = URL(string: baseURl + path) else { return }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = body
                    
                    
                    
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        
                        if let response = response {
                            print(response)
                        }
                        
                        if let data = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                print(json)
                            } catch {
                                print(error)
                            }
                        }
                    }.resume()
                }
            }
        }

        
        
    }
}
