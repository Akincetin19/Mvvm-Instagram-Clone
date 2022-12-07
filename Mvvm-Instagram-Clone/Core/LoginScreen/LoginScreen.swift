//
//  LoginScreen.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 7.12.2022.
//

import UIKit
protocol LoginScreenInterface: AnyObject {
    func configureSignInButton()
}

class LoginScreen: UIViewController {
    private var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSignInButton()
    }
}
extension LoginScreen: LoginScreenInterface {
    func configureSignInButton() {
        signInButton = UIButton(type: .system)
        signInButton.setTitle("Kayıt Ol", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(signInButton)
        signInButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 50, width: 0, paddingTop: 0, paddingLeft: 20, paddingRight: -20, paddingBottom: 0)
        signInButton.addTarget(self, action: #selector(runSignInScreen), for: .touchUpInside)
    }
    @objc private func runSignInScreen() {
        let signInScreen = ViewController()
        signInScreen.modalPresentationStyle = .fullScreen
        self.present(signInScreen, animated: true)
    }
}
