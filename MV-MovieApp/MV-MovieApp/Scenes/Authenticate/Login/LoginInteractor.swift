//
//  LoginInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation
import UIKit.UIViewController
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

final class LoginInteractor: LoginInteractorProtocol {
    
    var delegate: LoginInteractorDelegate?
    var user: UserPresentation!
    
    init() { }
}

extension LoginInteractor {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        delegate?.handleOutput(.setLoginLoading(true))
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: presenter) { user, error in
            guard error == nil else { return }
            
            guard let authentication = user?.authentication,
                  let idToken        = authentication.idToken else { return }
            let credential           = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                     accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                self.delegate?.handleOutput(.setLoginLoading(false))
                
                guard error == nil else { return }
                
                let user  = UserPresentation(username: result?.user.displayName ?? "", email: result?.user.email ?? "")
                self.user = user
                
                self.delegate?.handleOutput(.showHomePage(self.user))
            }
        }
    }
}
