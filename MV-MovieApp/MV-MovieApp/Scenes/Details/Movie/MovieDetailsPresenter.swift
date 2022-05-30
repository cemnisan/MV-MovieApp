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
    
    var detailsViewModelCell = DetailsViewModelCell()
    
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
    
    func viewDidLoad() {
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
        detailsViewModelCell.movieCast = cast
            .filter { $0.profilePath != nil }
            .map { MovieCastPresentation(cast: $0) }
        view.showCast()
    }
    
    func showRelatedMovies(movies: [Movies]) {
        detailsViewModelCell.similarMovies = movies.map { MoviePresentation(movie: $0) }
        view.showRelatedMovies()
    }
    
    func showMovieDetail(with movieID: Int) {
        router.toMovieDetail(with: movieID)
    }
    
    func showCastDetail(with castID: String) {
        router.toCastDetail(with: castID)
    }
}
