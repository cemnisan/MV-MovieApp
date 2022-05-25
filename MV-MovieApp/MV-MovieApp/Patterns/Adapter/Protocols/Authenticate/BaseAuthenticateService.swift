//
//  BaseAuthenticateService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import UIKit.UIViewController
import Firebase
import AuthenticationServices

protocol BaseAuthenticateService {
    func login(withGooglePresenter presenter: UIViewController,
               completion: @escaping (Result<UserPresentation, Error>) -> Void)
    func getAppleCredential(withApplePresenter presenter: BaseAuthViewController, selectedAuthController: SelectAuthController)
    func loginWithAppleCredential(credential appleCredential: ASAuthorizationAppleIDCredential,
                                  completion: @escaping (Result<UserPresentation, Error>) -> Void)
}
