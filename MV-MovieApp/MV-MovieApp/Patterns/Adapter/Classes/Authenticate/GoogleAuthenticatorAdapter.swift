//
//  GoogleAuthenticatorAdapter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import CryptoKit

final class GoogleAuthenticatorAdapter {
    
    private let firebaseAuth = Auth.auth()
    private var currentNonce: String?
    
    init() {}
}

// MARK: - Base Sign In Service
extension GoogleAuthenticatorAdapter: BaseAuthenticateService {
    
    func login(withGooglePresenter presenter: UIViewController,
               completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config         = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: presenter) { [weak self] (user, error) in
            guard let self = self,
                  error == nil else { completion(.failure(error!)); return }
            
            guard let authentication = user?.authentication,
                  let idToken        = authentication.idToken else { return }
            let credential           = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                     accessToken: authentication.accessToken)
            self.firebaseAuth.signIn(with: credential) { (result, error) in
                guard error == nil else { completion(.failure(error!)); return }
                let user = UserPresentation(
                    fullName: result?.user.displayName ?? K.Auth.dummyName,
                    username: K.Auth.dummyName,
                    email: result?.user.email ?? K.Auth.unavailableEmail,
                    profilePic: result?.user.photoURL?.absoluteString ?? K.Auth.dummyProfilePic,
                    backgroundPic: K.Auth.dummyBackgroundPic,
                    id: result?.user.uid ?? "")
                completion(.success(user))
            }
        }
    }
    
    func getAppleCredential(withApplePresenter presenter: BaseAuthViewController,
                            selectedAuthController: SelectAuthController) {
        let nonce               = randomNonceString()
        currentNonce            = nonce
        let appleIDProvider     = ASAuthorizationAppleIDProvider()
        let request             = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce           = sha256(nonce)
        
        let authorizantalController = ASAuthorizationController(authorizationRequests: [request])
        switch selectedAuthController {
        case .login:
            authorizantalController.delegate = presenter as? LoginViewController
            authorizantalController.presentationContextProvider = presenter as? LoginViewController
        case .register:
            authorizantalController.delegate = presenter as? RegisterViewController
            authorizantalController.presentationContextProvider = presenter as? RegisterViewController
        }
        authorizantalController.performRequests()
    }
    
    func loginWithAppleCredential(credential appleCredential: ASAuthorizationAppleIDCredential,
                                  completion: @escaping (Result<UserPresentation, Error>) -> Void) {
        guard let nonce         = currentNonce else { return }
        guard let appleIDToken  = appleCredential.identityToken else { return }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else { return }
        let credential          = OAuthProvider.credential(withProviderID: "apple.com",
                                                           idToken: idTokenString,
                                                           rawNonce: nonce)
        firebaseAuth.signIn(with: credential) { (result, error) in
            guard error == nil else { completion(.failure(error!)); return }
            let user = UserPresentation(
                fullName: result?.user.displayName ?? K.Auth.dummyName,
                username: K.Auth.dummyName,
                email: result?.user.email ?? K.Auth.unavailableEmail,
                profilePic: result?.user.photoURL?.absoluteString ?? K.Auth.dummyProfilePic,
                backgroundPic: K.Auth.dummyBackgroundPic,
                id: result?.user.uid ?? "")
            completion(.success(user))
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
                fullName: result?.user.displayName ?? K.Auth.dummyName,
                username: K.Auth.dummyName,
                email: result?.user.email ?? K.Auth.unavailableEmail,
                profilePic: result?.user.photoURL?.absoluteString ?? K.Auth.dummyProfilePic,
                backgroundPic: K.Auth.dummyBackgroundPic,
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
                fullName: result?.user.displayName ?? K.Auth.dummyName,
                username: username,
                email: result?.user.email ?? K.Auth.unavailableEmail,
                profilePic: result?.user.photoURL?.absoluteString ?? K.Auth.dummyProfilePic,
                backgroundPic: K.Auth.dummyBackgroundPic,
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

// MARK: - Sign in Helpers
extension GoogleAuthenticatorAdapter {
    // Received from https://github.com/firebase/quickstart-ios/blob/master/authentication/AuthenticationExample/ViewControllers/AuthViewController.swift
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0 )
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(
                    kSecRandomDefault,
                    1,
                    &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 { return }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}
