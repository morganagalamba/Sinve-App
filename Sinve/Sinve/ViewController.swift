//
//  ViewController.swift
//  Sinve
//
//  Created by Morgana Galamba on 21/09/22.
//

import UIKit
import AVFoundation

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rootVc = ScannerViewController()
        let tabOne = UINavigationController(rootViewController: rootVc)
        let tabOneBarItem = UITabBarItem(title: "Vendas", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        tabOne.tabBarItem = tabOneBarItem
        
        
        let rootVc2 = ProfileViewController()
        let tabTwo = UINavigationController(rootViewController: rootVc2)
        let tabTwoBarItem2 = UITabBarItem(title: "Perfil", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
}

