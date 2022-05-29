//
//  CastDetailsPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.People

final class CastDetailsPresenter {
    
    private unowned var view: CastDetailsPresenterOutput
    private let interactor: CastDetailsInteractorProtocol
    private let router: CastDetailsRoute
    
    init(view: CastDetailsPresenterOutput,
         interactor: CastDetailsInteractorProtocol,
         router: CastDetailsRoute) {
        self.view           = view
        self.interactor     = interactor
        self.router         = router
        interactor.delegate = self
    }
}

extension CastDetailsPresenter: CastDetailsPresenterProtocol {
    
    func loadCastDetail() {
        interactor.loadCastDetails()
    }
}

extension CastDetailsPresenter: CastDetailsInteractorOutput {
    
    func showCastDetails(details: People) {
        let actorDetailPresentation = ActorDetailPresentation(people: details)
        view.showCastDetails(details: actorDetailPresentation)
    }
}
