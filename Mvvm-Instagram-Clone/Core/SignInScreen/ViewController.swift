//
//  ViewController.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 5.12.2022.
//

import UIKit
import JGProgressHUD

protocol ViewControllerInterface: AnyObject {
    func configureSelectImageButton()
    func configureEmailTextField()
    func configureUserNameTextField()
    func configurePasswordField()
    func configureStackView()
    func configureSignInButton()
    func handleWithError(error: Error)
    func handleWithAuthDataResult()
    func makeAlert(error: Error)
}

class ViewController: UIViewController {

    var selectImageButton: UIButton!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var userNameTextField: UITextField!
    var signInButton: UIButton!
    let viewModel = SignInViewModel()
    var hud = JGProgressHUD(style: .light)


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}
extension ViewController: ViewControllerInterface {
    func configureSignInButton() {
        signInButton = UIButton(type: .system)
        signInButton.setTitle("Kayıt Ol", for: .normal)
        signInButton.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        signInButton.layer.cornerRadius = 6
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signInButton.setTitleColor(.white, for: .normal)
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    func configureStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signInButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.anchor(top: selectImageButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,height: 230, width: nil, paddingTop: 20, paddingLeft: 20, paddingRight: -20, paddingBottom: 0)
    }
    
    func configurePasswordField() {
        passwordTextField = UITextField()
        emailTextField.configureTextField(subView: passwordTextField, placeHolder: "Şifrenizi Giriniz")
        passwordTextField.isSecureTextEntry = true
    }
    func configureUserNameTextField() {
        userNameTextField = UITextField()
        emailTextField.configureTextField(subView: userNameTextField, placeHolder: "Kullanıcı Adınızı Giriniz")
    }
    func configureEmailTextField() {
        emailTextField = UITextField()
        emailTextField.configureTextField(subView: emailTextField, placeHolder: "Emailinizi Giriniz")
    }
    func configureSelectImageButton() {
        selectImageButton = UIButton(type: .system)
        view.addSubview(selectImageButton)
        selectImageButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, height: 150, width: 150, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
        
        selectImageButton.addTarget(self, action: #selector(imageButtonClicked), for: .touchUpInside)
        
        selectImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        selectImageButton.setImage(#imageLiteral(resourceName: "Fotograf_Sec").withRenderingMode(.alwaysOriginal), for: .normal)
        self.selectImageButton.imageView?.contentMode = .scaleAspectFill
        
    }
    func handleWithError(error: Error) {
        hud.dismiss(animated: true)
        makeAlert(error: error)
    }
    func handleWithAuthDataResult() {
        hud.dismiss(animated: true)
        emailTextField.text = ""
        userNameTextField.text = ""
        passwordTextField.text = ""
        
    }
    func makeAlert(error: Error) {
        let dialogMessage = UIAlertController(title: "Hata", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Tamam", style: .default)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
extension ViewController {
    @objc private func signInButtonClicked() {
        hud.show(in: self.view)
        hud.textLabel.text = "Kaydınız Gerçekleşiyor"
        viewModel.signInClicked(email: emailTextField.text!, password: passwordTextField.text!, username: userNameTextField.text!, userProfilPicture: selectImageButton.imageView!)
    }
    @objc private func imageButtonClicked() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        self.selectImageButton.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.selectImageButton.imageView?.contentMode = .scaleAspectFit
        
        selectImageButton.layer.masksToBounds = true
        selectImageButton.layer.cornerRadius = selectImageButton.frame.width / 2
     
        selectImageButton.layer.borderColor = UIColor.darkGray.cgColor
        selectImageButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
}
