//
//  LoginScreen.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 7.12.2022.
//

import UIKit
protocol LoginScreenInterface: AnyObject {
    func configureSignInButton()
    func configureTopView()
    func configureTopViewImage()
    func configureEmailTextField()
    func configurePasswordField()
    func configureLogInButton()
    func configureStackView()
    func handleWithError(error: Error)
    func goToTabbar()
}

class LoginScreen: UIViewController {
    private var viewModel = LoginScreenViewModel()
    
    private var signInButton: UIButton!
    private var topView: UIView!
    private var topViewImage: UIImageView!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        view.backgroundColor = .white
        viewModel.ViewDidload()
    }
}
extension LoginScreen: LoginScreenInterface {
    
    
    
    func configureEmailTextField() {
        emailTextField = UITextField()
        emailTextField.configureTextField(subView: emailTextField, placeHolder: "Emailinizi Giriniz")
    }
    
    func configurePasswordField() {
        passwordTextField = UITextField()
        emailTextField.configureTextField(subView: passwordTextField, placeHolder: "Şifrenizi Giriniz")
        passwordTextField.isSecureTextEntry = true
    }
    func configureLogInButton() {
        logInButton = UIButton(type: .system)
        logInButton.setTitle("Kayıt Ol", for: .normal)
        logInButton.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        logInButton.layer.cornerRadius = 6
        logInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.addTarget(self, action: #selector(LogInButtonClicked), for: .touchUpInside)
    }
    func configureStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, logInButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.anchor(top: topView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,height: 180, width: nil, paddingTop: 40, paddingLeft: 20, paddingRight: -20, paddingBottom: 0)
    }
    func configureSignInButton() {
        signInButton = UIButton(type: .system)
        signInButton.setTitle("Hesabın Yok Mu? Kayıt Ol", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(signInButton)
        signInButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 50, width: 0, paddingTop: 0, paddingLeft: 20, paddingRight: -20, paddingBottom: 0)
        signInButton.addTarget(self, action: #selector(runSignInScreen), for: .touchUpInside)
    }
    func configureTopView() {
        topView = UIView()
        topView.backgroundColor = UIColor(red: 0, green: 120, blue: 175, alpha: 1)
        view.addSubview(topView)
        topView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 200, width: 0, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
    }
    func configureTopViewImage() {
        topViewImage = UIImageView()
        topViewImage.image = UIImage(named: "Logo_Instagram")
        topViewImage.contentMode = .scaleAspectFill
        view.addSubview(topViewImage)
        topViewImage.anchor(top: topViewImage.topAnchor, bottom: nil, leading: topViewImage.trailingAnchor, trailing: topViewImage.leadingAnchor, height: 50, width: 200, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
        topViewImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        topViewImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
    }
    func handleWithError(error: Error) {
        self.makeAlert(view: self, error: error)
    }
    func goToTabbar() {
        let keywindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        guard let mainTabbarController = keywindow?.rootViewController as? MainTabbarController else {return}
        mainTabbarController.startTabbarController()
        self.dismiss(animated: true)
    }
    
}
extension LoginScreen {
    @objc private func LogInButtonClicked() {
        viewModel.Login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    @objc private func runSignInScreen() {
        let signInScreen = ViewController()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(signInScreen, animated: true)
    }
}

