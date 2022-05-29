//
//  ActorDetailsBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit
import MovieDB_Wrapper

final class ActorDetailsBuilder {
    static func make(with currentCastID: String) -> UIViewController {
        let view       = ActorDetailsViewController()
        let interactor = ActorDetailsInteractor(peopleService: PeopleService(),
                                                currentActorID: currentCastID)
        let router     = ActorDetailsRouter(view: view)
        let presenter  = ActorDetailsPresenter(view: view,
                                             interactor: interactor,
                                             router: router)
        view.actorDetailsPresenter = presenter
        return view
    }
}
