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
        
        service.login(presenterViewController: presenter) { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            
            switch result {
            case .success(_):
                self.delegate?.showHome()
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }
}
