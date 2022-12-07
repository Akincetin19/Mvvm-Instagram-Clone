//
//  ProfileScreen.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 6.12.2022.
//
import UIKit

protocol ProfileScreenInterface: AnyObject{
    func configureView()
    func registerHeader()
    func configureLogOut()
}
final class ProfileScreen: UICollectionViewController {
    let postId = "postId"
    let viewModel = ProfileScreenViewModel()
    private var currentuser : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 0, width: 0, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
    }
}
extension ProfileScreen: ProfileScreenInterface {
    
    func configureView() {
        self.collectionView.backgroundColor = .white
        self.viewModel.getUserInfo { result in
            switch result {
            case.success(let data):
                self.navigationItem.title = data.userName
                self.currentuser = data
                self.collectionView.reloadData()
            case.failure(let error):
                self.makeAlert(view: self, error: error)
            }
        }
    }
    func configureLogOut() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Ayarlar").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logOut))
    }
    @objc private func logOut() {
        self.alertLogOut()
    }
    private func alertLogOut() {
        let dialogMessage = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "Oturumu Kapat", style: .destructive) { (_) in
            self.viewModel.logOut { result in
                switch result {
                case.success(_):
                    let loginScreen = LoginScreen()
                    let navigationController = UINavigationController(rootViewController: loginScreen)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true)
                case.failure(_):
                    self.makeAlert(view: self, error: "Bir Hata Meydana Geldi" as! Error)
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        dialogMessage.addAction(logout)
        dialogMessage.addAction(cancel)
        present(dialogMessage, animated: true, completion: nil)
    }
    func registerHeader() {
        collectionView.register(ProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: postId)
    }
}
 extension ProfileScreen: UICollectionViewDelegateFlowLayout {
     override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! ProfileHeaderCell
         header.user = currentuser
         return header
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         return CGSize(width: view.frame.width, height: 200 )
     }
     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 10
     }
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postId, for: indexPath)
         cell.backgroundColor = .blue
         return cell
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = (Int(view.frame.width - 5)) / 3
         return CGSize(width: width, height: width)
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 2
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 2
     }
     
 }
 
