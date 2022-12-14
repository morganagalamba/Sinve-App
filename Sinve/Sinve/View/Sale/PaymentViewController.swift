//
//  PaymentViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 09/10/22.
//

import UIKit

class PaymentViewController: UIViewController {
    
    public let ok: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.setTitle("Voltar para vendas", for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action:#selector(okPressed), for: .touchUpInside)
        return button
    }()
    
    public var confirm: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "PineTree")
        label.text = "Venda realizada!"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        view.backgroundColor = UIColor(named: "BackGround")
        view.addSubview(confirm)
        view.addSubview(ok)
        setupConstraints()
        
    }
    
    private func setupConstraints(){
        confirm.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        confirm.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        ok.topAnchor.constraint(equalTo: confirm.bottomAnchor, constant: 16).isActive = true
        ok.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func okPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    

}
