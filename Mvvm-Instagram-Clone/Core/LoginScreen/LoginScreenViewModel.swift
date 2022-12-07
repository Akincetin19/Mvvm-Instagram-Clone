//
//  LoginScreenViewModel.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 7.12.2022.
//

import Foundation

protocol LoginScreenViewModelInterface {
    var view: LoginScreenInterface? {get set}
    func ViewDidload()
    func Login(email: String, password: String)
}

final class LoginScreenViewModel {
    weak var view: LoginScreenInterface?
    private var service = AuthService()
}
extension LoginScreenViewModel: LoginScreenViewModelInterface {
    func ViewDidload() {
        view?.configureSignInButton()
        view?.configureTopView()
        view?.configureTopViewImage()
        view?.configureEmailTextField()
        view?.configurePasswordField()
        view?.configureLogInButton()
        view?.configureStackView()
    }
    func Login(email: String, password: String) {
        service.login(email: email, password: password) { result in
            
            switch result {
            case.failure(let error):
                self.view?.handleWithError(error: error)
            case.success(_):
                self.view?.goToTabbar()
            }
        }
    }
}

