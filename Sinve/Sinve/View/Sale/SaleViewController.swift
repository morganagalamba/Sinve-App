//
//  SaleViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 28/09/22.
//

import UIKit

class SaleViewController: UIViewController {
    
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
        view.backgroundColor = UIColor(named: "BackGround")
        view.addSubview(addSale)
        
        self.title = "Vendas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupConstraints()
    }
    
    private func setupConstraints(){
        addSale.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addSale.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func pressed() {
        var view = ScannerViewController()
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }

}
