//
//  AddProviderViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 19/10/22.
//

import UIKit

class AddProviderViewController: UIViewController {
    
    let addProviderView = AddProviderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addProviderView
        self.title = "Cadastrar Fornecedor"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "BackGround")
    }

}
