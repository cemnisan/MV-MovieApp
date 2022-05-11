//
//  BaseAuthenticateInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import Foundation
import UIKit.UIViewController

class BaseAuthenticateInteractor {
    
    private let service: BaseAuthenticateService
    weak var delegate: BaseAuthenticateInteractorOutput?
    
    init(service: BaseAuthenticateService) {
        self.service = service
    }
}

extension BaseAuthenticateInteractor: BaseAuthenticateInteractorProtocol {
    
    func loginWithGoogle(presenterController presenter: UIViewController) {
        delegate?.displayLoadingIndicator()
        
        service.login(presenterViewController: presenter) { [weak self] in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            AppData.enableAutoLogin = true
            self.delegate?.showHome()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.delegate?.showError(error: error)
        }
    }
}
