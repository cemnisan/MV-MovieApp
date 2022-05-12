//
//  GoogleAuthenticatorAdapter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

final class GoogleAuthenticatorAdapter {
    
    private let firebaseAuth = Auth.auth()
    
    init() {}
}

// MARK: - Google Sign In Service
extension GoogleAuthenticatorAdapter: BaseAuthenticateService {
    
    func login(presenterViewController presenter: UIViewController,
               completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config         = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: presenter) { (user, error) in
            guard error == nil else { completion(.failure(error!)); return }
            
            guard let authentication = user?.authentication,
                  let idToken        = authentication.idToken else { return }
            let credential           = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                     accessToken: authentication.accessToken)
            self.firebaseAuth.signIn(with: credential) { (result, error) in
                guard error == nil else { completion(.failure(error!)); return }
                
                let user = UserPresentation(
                    fullName: result?.user.displayName ?? "Anonymous",
                    username: "",
                    email: result?.user.email ?? "Unavailable Email",
                    imageURL: result?.user.photoURL?.absoluteString ?? "https://dummyimage.com/120x120/000/0011ff.png",
                    id: result?.user.uid ?? "")
                completion(.success(user))
            }
        }
    }
}

// MARK: - Login Service
extension GoogleAuthenticatorAdapter: LoginService {
    
    func login(with email: String,
               password: String,
               completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        firebaseAuth.signIn(withEmail: email,
                            password: password) { (result, error) in
            guard error == nil else { completion(.failure(error!)); return }
            
            let user = UserPresentation(
                fullName: result?.user.displayName ?? "Anonymous",
                username: "",
                email: result?.user.email ?? "Unavailable Email",
                imageURL: (result?.user.photoURL?.absoluteString ?? "https://dummyimage.com/120x120/000/0011ff.png"),
                id: result?.user.uid ?? "")
            completion(.success(user))
        }
    }
}

// MARK: - Register Service
extension GoogleAuthenticatorAdapter: RegisterService {
    
    func register(with username: String,
                  email: String,
                  password: String,
                  completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        firebaseAuth.createUser(withEmail: email,
                                password: password) { (result, error) in
            guard error == nil else { completion(.failure(error!)); return }
            
            let user = UserPresentation(
                fullName: result?.user.displayName ?? "Anonymous",
                username: username,
                email: result?.user.email ?? "Unavailable Email",
                imageURL: result?.user.photoURL?.absoluteString ?? "https://dummyimage.com/120x120/000/0011ff.png",
                id: result?.user.uid ?? "")
            completion(.success(user))
        }
    }
}

// MARK: - User Service
extension GoogleAuthenticatorAdapter: UserService {
    func signOut(completed: @escaping () -> Void,
                 failure: @escaping (Error) -> Void) {
        do {
            try firebaseAuth.signOut()
            completed()
        } catch {
            failure(error)
        }
    }
}
