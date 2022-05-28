//
//  MovieDetailsPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import Foundation
import MovieDB_Wrapper

final class MovieDetailPresenter {
    
    private unowned var view: MovieDetailPresenterOutput
    private let interactor: MovieDetailInteractorProtocol
    private let router: MovieDetailRoute
    
    init(view: MovieDetailPresenterOutput,
         interactor: MovieDetailInteractorProtocol,
         router: MovieDetailRoute) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        
        interactor.delegate = self
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    func loadMovieServiceWithTaskgroup() {
        interactor.loadMovieServicesWithTaskgroup()
    }
    
    func userDidSelectItem(at indexPath: IndexPath) {
        interactor.userDidSelectItem(at: indexPath)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutput {
    
    func showMovieDetail(movie: MovieDetail) {
        let movieDetailPresentation = MovieDetailPresentation(detail: movie)
        view.showMovieDetail(movie: movieDetailPresentation)
    }
    
    func showCast(cast: [Cast]) {
        let movieCastPresentation = cast
            .filter { $0.profilePath != nil }
            .map { MovieCastPresentation(cast: $0) }
        view.showCast(cast: movieCastPresentation)
    }
    
    func showRelatedMovies(movies: [Movies]) {
        let similarMovies = movies.map { MoviePresentation(movie: $0) }
        view.showRelatedMovies(movies: similarMovies)
    }
    
    func showMovieDetail(with movieID: Int) {
        router.toDetail(with: movieID)
    }
}
