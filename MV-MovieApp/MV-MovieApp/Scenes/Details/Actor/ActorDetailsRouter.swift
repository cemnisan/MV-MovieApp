//
//  ActorDetailsRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit

final class ActorDetailsRouter {
    
    private unowned var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension ActorDetailsRouter: ActorDetailsRoute {
    
    func toMovieDetails(with movieID: Int) {
        let targetView = MovieDetailsBuilder.make(with: movieID)
        view.navigationController?.pushViewController(targetView, animated: true)
    }
}
