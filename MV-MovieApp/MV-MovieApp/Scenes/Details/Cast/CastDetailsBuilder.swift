//
//  CastDetailsBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit
import MovieDB_Wrapper

final class CastDetailsBuilder {
    static func make(with currentCastID: String) -> UIViewController {
        let view       = CastDetailsViewController()
        let interactor = CastDetailsInteractor(peopleService: PeopleService(),
                                               currentCastID: currentCastID)
        let router     = CastDetailsRouter(view: view)
        let presenter  = CastDetailsPresenter(view: view,
                                             interactor: interactor,
                                             router: router)
        view.castDetailsPresenter = presenter
        return view
    }
}
