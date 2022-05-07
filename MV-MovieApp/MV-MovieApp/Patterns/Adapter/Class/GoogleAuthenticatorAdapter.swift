//
//  GoogleAuthenticatorAdapter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

final class GoogleAuthenticatorAdapter {
    
    private let firebase = FirebaseApp.app()
    
    init() {}
}

extension GoogleAuthenticatorAdapter: AuthenticationService {
    
    func login(presenterViewController presenter: UIViewController,
                         completed: @escaping (Result<UserPresentation, Error>) -> Void) {
        
        guard let clientID = firebase?.options.clientID else { return }
        let config         = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: presenter) { (user, error) in
            guard error == nil else { completed(.failure(error!)); return }
            
            guard let authentication = user?.authentication,
                  let idToken        = authentication.idToken else { return }
            let credential           = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                     accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (result, error) in
                guard error == nil else { completed(.failure(error!)); return }
                
                let user = UserPresentation(username: result?.user.displayName ?? "",
                                            email: result?.user.email ?? "")
                completed(.success(user))
            }
        }
    }
    
    func login(with email: String,
               password: String,
               completed: @escaping (Result<UserPresentation, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { (result, error) in
            guard error == nil else { completed(.failure(error!)); return }
            let user = UserPresentation(username: result?.user.displayName ?? "", email: result?.user.email ?? "")
            completed(.success(user))
        }
    }
    
    func register(with username: String,
                  email: String,
                  password: String,
                  completed: @escaping (Result<UserPresentation, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { (result, error) in
            guard error == nil else { completed(.failure(error!)); return }
            let user = UserPresentation(username: username, email: result?.user.displayName ?? "")
            completed(.success(user))
        }
    }
}
