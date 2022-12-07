//
//  MainTabbarController.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 6.12.2022.
//

import UIKit
 
class MainTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = UICollectionViewFlowLayout()
        let profileScreen = ProfileScreen(collectionViewLayout: layout)
        view.backgroundColor = .white
        
        let navigatinController = UINavigationController(rootViewController: profileScreen)
        
        navigatinController.tabBarItem.image = UIImage(named: "Profil")
        navigatinController.tabBarItem.selectedImage = UIImage(named: "Profil_Secili")
        tabBar.tintColor = .black
        viewControllers = [navigatinController, UIViewController()]
        
    }
}
