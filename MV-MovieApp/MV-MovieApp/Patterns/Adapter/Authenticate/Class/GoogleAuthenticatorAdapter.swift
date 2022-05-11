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
    
    private let firebaseAuth = Auth.auth()
    
    init() {}
}

// MARK: - Google Sign In Service
extension GoogleAuthenticatorAdapter: BaseAuthenticateService {
    
    func login(presenterViewController presenter: UIViewController,
               completed: @escaping () -> Void,
               failure: @escaping (Error) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config         = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: presenter) { (user, error) in
            guard error == nil else { failure(error!); return }
            
            guard let authentication = user?.authentication,
                  let idToken        = authentication.idToken else { return }
            let credential           = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                     accessToken: authentication.accessToken)
            self.firebaseAuth.signIn(with: credential) { (result, error) in
                guard error == nil else { failure(error!); return }
                
                completed()
            }
        }
    }
}

// MARK: - Login Service
extension GoogleAuthenticatorAdapter: LoginService {
    
    func login(with email: String,
               password: String,
               completed: @escaping () -> Void,
               failure: @escaping (Error) -> Void) {
        firebaseAuth.signIn(withEmail: email,
                            password: password) { (result, error) in
            guard error == nil else { failure(error!); return }
            
            completed()
        }
    }
}

// MARK: - Register Service
extension GoogleAuthenticatorAdapter: RegisterService {
    
    func register(with username: String,
                  email: String,
                  password: String,
                  completed: @escaping (String) -> Void,
                  failure: @escaping (Error) -> Void) {
        firebaseAuth.createUser(withEmail: email,
                                password: password) { (result, error) in
            guard error == nil else { failure(error!); return }
            completed(username)
        }
    }
}

// MARK: - User Service
extension GoogleAuthenticatorAdapter: UserService {
    
    func getCurrentUser() -> UserPresentation? {
        let user = Auth.auth().currentUser
        
        if let user = user {
            let userPresentetation = UserPresentation(
                username: user.displayName,
                email: user.email ?? "",
                imageURL: (user.photoURL ?? URL(string: "https://dummyimage.com/120x120/000/0011ff.png"))!)
            return userPresentetation
        }
        return nil
    }
    
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
