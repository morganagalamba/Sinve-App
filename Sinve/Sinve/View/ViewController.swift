//
//  ViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 21/09/22.
//

import UIKit
import AVFoundation

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    let scannerViewController = ScannerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scannerViewController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        let tabOne = UINavigationController(rootViewController: scannerViewController)
        let tabOneBarItem = UITabBarItem(title: "Vendas", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        tabOne.tabBarItem = tabOneBarItem
        
        
        let rootVc2 = ProfileViewController()
        let tabTwo = UINavigationController(rootViewController: rootVc2)
        let tabTwoBarItem2 = UITabBarItem(title: "Perfil", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
}

extension ViewController: ScannerViewDelegate {
    func didFindScannedText(text: String) {
       // coloca exibindo o negocio em algum canto
    }
}

