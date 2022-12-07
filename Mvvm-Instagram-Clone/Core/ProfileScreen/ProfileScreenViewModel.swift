//
//  ProfileScreenViewModel.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 6.12.2022.
//

import Foundation

protocol ProfileScreenViewModelInterface {
    var view: ProfileScreenInterface? {get set}
    func getUserInfo(completion: @escaping (Result<User, Error>) -> ())
    func viewDidLoad()
    func logOut(completion: @escaping (Result<String ,Error>) -> ())
}

final class ProfileScreenViewModel {
    weak var view: ProfileScreenInterface?
    private var service = UserService()
    private var authService = AuthService()
    var userData = [User]()
}
extension ProfileScreenViewModel: ProfileScreenViewModelInterface {
    func viewDidLoad() {
        view?.configureView()
        view?.registerHeader()
        view?.configureLogOut()
    }
    
    func logOut(completion: @escaping (Result<String, Error>) -> ()) {
        authService.logOut { result in
            switch result {
            case.success(let data):
                completion(.success(data))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getUserInfo(completion: @escaping (Result<User, Error>) -> ()) {
        service.gerUserInfo { result in
            switch result {
            case.failure(let error):
                completion(.failure(error))
            case.success(let data):
                self.userData.append(data)
                completion(.success(data))
            }
        }
    }
}
