//
//  MovieDetailsBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 20.05.2022.
//

import UIKit
import MovieDB_Wrapper

final class MovieDetailsBuilder {
    
    static func make(with movieID: Int) -> UIViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor(
            movieService: MovieService(),
            currentMovieID: movieID)
        let router = MovieDetailRouter(view: view)
        let presenter = MovieDetailPresenter(
            view: view,
            interactor: interactor,
            router: router)
        view.detailsPresenter = presenter
        return view
    }
}
