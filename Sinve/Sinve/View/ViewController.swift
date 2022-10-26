//
//  ViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 21/09/22.
//

import UIKit
import AVFoundation

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        let tabOne = UINavigationController(rootViewController: StorageViewController())
        let tabOneBarItem = UITabBarItem(title: "Estoque", image: UIImage(systemName: "shippingbox"), selectedImage: UIImage(systemName: "shippingbox.fill"))
        tabOne.tabBarItem = tabOneBarItem
        
        

        let tabTwo = UINavigationController(rootViewController: SaleViewController())
        let tabTwoBarItem2 = UITabBarItem(title: "Vendas", image: UIImage(systemName: "dollarsign.square"), selectedImage: UIImage(systemName: "dollarsign.square.fill"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        let tabThree = UINavigationController(rootViewController: ProviderViewController())
        let tabTwoBarItem3 = UITabBarItem(title: "Fornecedores", image: UIImage(systemName: "box.truck"), selectedImage: UIImage(systemName: "box.truck.fill"))
        tabThree.tabBarItem = tabTwoBarItem3
    
        self.tabBar.backgroundColor = UIColor(named: "BackGround")
        
        self.viewControllers = [tabOne, tabTwo, tabThree]
    }
    
}


