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
        button.backgroundColor = .brown
        button.setTitle("Nova venda", for: .normal)
        button.addTarget(self, action:#selector(pressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addSale)
        setupConstraints()
    }
    
    private func setupConstraints(){
        addSale.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addSale.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func pressed() {
        let view = ScannerViewController()
        self.navigationController?.pushViewController(view, animated: true)
    }

}
