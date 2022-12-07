//
//  AuthService.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 5.12.2022.
//

import UIKit
import Firebase
import FirebaseStorage


final class AuthService {
    
    let authService = Auth.auth()
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
        authService.signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let authDataResult = authDataResult else {return}
            completion(.success(authDataResult))
        }
    }
    func createUser(email: String, password: String, username: String, userProfilPicture: UIImageView, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
        authService.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let result = result else {return}
            let userID = result.user.uid
            let error = self.uploadProfilPicture(username: username,userID: userID,userProfilPicture: userProfilPicture)
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(result))
        }
    }
    private func uploadProfilPicture(username: String, userID: String, userProfilPicture: UIImageView) -> Error? {
        var returnError: Error?
        let nameOfPicture = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/ProfilePictures/\(nameOfPicture)")
        let profilePicture = userProfilPicture.image?.jpegData(compressionQuality: 0.8)
        if let profilePicture = profilePicture {
            ref.putData(profilePicture, metadata: nil) { _, error in
                if let error = error {
                    returnError = error
                }
                ref.downloadURL { url, error in
                    if let error = error {
                        returnError = error
                    }
                    if let url = url {
                        print(url)
                        returnError = self.uploadUserInfo(userName: username, userID: userID, url: url.absoluteString)
                    }
                }
            }
        }
        return returnError
    }
    private func uploadUserInfo(userName: String, userID: String, url: String) -> Error?{
        var returnError: Error?
        
        let data = ["userName": userName,
                    "userID": userID,
                    "profilePictureUrl": url]
        Firestore.firestore().collection("Users").document(userID).setData(data) { error in
            if let error = error {
                print(error.localizedDescription)
                returnError = error
            }
        }
        return returnError
    }
    func logOut (completion: @escaping (Result<String ,Error>) -> ()) {
        do {
            try authService.signOut()
            completion(.success("Başarıyla Çıkış Yapıldı"))
        } catch let error {
            completion(.failure(error))
        }
    }
    func isUserLogin() -> Bool {
        if authService.currentUser != nil {
            return true
        }
        else{
            return false
        }
    }
}
