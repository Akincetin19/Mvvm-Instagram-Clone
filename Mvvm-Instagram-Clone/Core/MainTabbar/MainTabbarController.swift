//
//  MainTabbarController.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 6.12.2022.
//

import UIKit
 
protocol MainTabbarControllerInterface: AnyObject {
    func configureView()
    func startLoginScreen()
    func startTabbarController()
}

class MainTabbarController: UITabBarController {
    private let viewModel = MainTabbarViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}
extension MainTabbarController: MainTabbarControllerInterface {
    func configureView() {
        
    }
    func startLoginScreen() {
        DispatchQueue.main.async {
            lazy var loginScreen = LoginScreen()
            lazy var navigationController = UINavigationController(rootViewController: loginScreen)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        }
        return
    }
    func startTabbarController() {
        
        lazy var homeScreen = UIViewController()
        lazy var homeNavController = UINavigationController(rootViewController: homeScreen)
        homeNavController.tabBarItem.image = UIImage(named: "Ana_Ekran_Secili")
        
        lazy var searchController = UIViewController()
        lazy var searchNavController = UINavigationController(rootViewController: searchController)
        searchNavController.tabBarItem.image = UIImage(named: "Ara_Secili_Degil")
        searchNavController.tabBarItem.selectedImage = UIImage(named: "Ara_Secili")
        
        lazy var addController = UIViewController()
        lazy var addNavController = UINavigationController(rootViewController: addController)
        addNavController.tabBarItem.image = UIImage(named: "Ekle_Secili_Degil")
        addNavController.tabBarItem.selectedImage = UIImage(named: "Ekle_Secili")
        
        lazy var favoriteController = UIViewController()
        lazy var favoriteNavController = UINavigationController(rootViewController: favoriteController)
        favoriteNavController.tabBarItem.image = UIImage(named: "Begeni_Secili_Degil")
        favoriteNavController.tabBarItem.selectedImage = UIImage(named: "Begeni_Secili")
        
        
        lazy var layout = UICollectionViewFlowLayout()
        lazy var profileScreen = ProfileScreen(collectionViewLayout: layout)
        view.backgroundColor = .white
        lazy var navigatinController = UINavigationController(rootViewController: profileScreen)
        navigatinController.tabBarItem.image = UIImage(named: "Profil")
        navigatinController.tabBarItem.selectedImage = UIImage(named: "Profil_Secili")
        tabBar.tintColor = .black
        viewControllers = [homeNavController, searchNavController, addNavController, favoriteNavController, navigatinController]
        guard let items = tabBar.items else {return}
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }
}
extension MainTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let index = viewControllers?.firstIndex(of: viewController) else {return true}
        
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            
            let fotografSeciciController = AddPhotoController(collectionViewLayout: layout)
            
            let navController = UINavigationController(rootViewController: fotografSeciciController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
}

