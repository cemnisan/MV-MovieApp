//
//  MovieDetailsRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import UIKit

final class MovieDetailRouter {
    
    private unowned var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension MovieDetailRouter: MovieDetailRoute {
    
    func toDetail(with movieID: Int) {
        let targetView = MovieDetailsBuilder.make(with: movieID)
        view.navigationController?.pushViewController(targetView, animated: true)
    }
}
