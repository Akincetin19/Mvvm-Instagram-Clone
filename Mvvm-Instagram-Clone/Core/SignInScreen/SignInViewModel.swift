//
//  SignInViewModel.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 5.12.2022.
//

import UIKit

protocol SignInViewModelProtocol {
    var view: ViewControllerInterface? {get set}
    func viewDidLoad()
    func signInClicked(email: String, password: String, username: String, userProfilPicture: UIImageView)
}

final class SignInViewModel {
    weak var view: ViewControllerInterface?
    private let authService = AuthService()
}
extension SignInViewModel: SignInViewModelProtocol {
    func viewDidLoad() {
        view?.configureSelectImageButton()
        view?.configureEmailTextField()
        view?.configureUserNameTextField()
        view?.configurePasswordField()
        view?.configureSignInButton()
        view?.configureStackView()
        view?.configureLogInButton()
    }
    func signInClicked(email: String, password: String, username: String, userProfilPicture: UIImageView) {
        authService.createUser(email: email, password: password, username: username, userProfilPicture: userProfilPicture) { result in
            switch result{
            case .failure(let error):
                self.view?.handleWithError(error: error)
            case.success(_):
                self.view?.handleWithAuthDataResult()
            }
        }
    }
}
