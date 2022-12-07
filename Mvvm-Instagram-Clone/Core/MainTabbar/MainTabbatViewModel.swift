//
//  MainTabbatViewModel.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 7.12.2022.
//

import Foundation

protocol MainTabbarViewModelInterface {
    var view: MainTabbarControllerInterface? {get set}
    func viewDidLoad()
    func isUserLogin()
    
}

final class MainTabbarViewModel {
    weak var view: MainTabbarControllerInterface?
    private let service = AuthService()
}
extension MainTabbarViewModel: MainTabbarViewModelInterface{
    func viewDidLoad() {
        isUserLogin()
    }
    
    func isUserLogin() {
        let controlUserLogin = service.isUserLogin()
        if controlUserLogin {
            view?.startTabbarController()
        }
        else {
            view?.startLoginScreen()
        }
    }
    
    
}
