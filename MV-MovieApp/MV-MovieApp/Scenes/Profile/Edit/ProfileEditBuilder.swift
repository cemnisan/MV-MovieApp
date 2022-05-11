//
//  ProfifeEditBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit

final class ProfileEditBuilder {
    
    static func make(with currentUser: UserPresentation) -> UIViewController {
        let view = ProfileEditViewController()
        let interactor = ProfileEditInteractor(currentUser: currentUser)
        let presenter = ProfileEditPresenter(interactor: interactor,
                                             view: view)
        view.profileEditPresenter = presenter
        return view
    }
}
