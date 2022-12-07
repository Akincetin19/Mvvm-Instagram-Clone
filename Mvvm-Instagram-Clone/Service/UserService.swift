//
//  UserService.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 6.12.2022.
//

import Foundation
import Firebase


final class UserService {
    
    func gerUserInfo(completion: @escaping (Result<User, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        Firestore.firestore().collection("Users").document(user.uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = snapshot?.data() else {return}
            var user = User()
            user.userName = data["userName"] as? String
            user.userID = data["userID"] as? String
            user.profilePictureUrl = data["profilePictureUrl"] as? String
            completion(.success(user))
        }
    }
    func downloadProfilePicture() {
        
    }
}
