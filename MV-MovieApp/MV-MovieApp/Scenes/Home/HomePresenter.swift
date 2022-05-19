//
//  HomePresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation
import MovieDB_Wrapper

// MARK: - Initialize
final class HomePresenter {
    
    private unowned let view: HomePresenterOutput
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
        
    init(view: HomePresenterOutput,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol) {
        self.view                = view
        self.interactor          = interactor
        self.router              = router
        
        self.interactor.delegate = self
    }
}

// MARK: - Presenter Protocol
extension HomePresenter: HomePresenterProtocol {
    
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }
    
    func loadHomeServicesWithTaskGroup() {
        interactor.loadHomeServicesWithTaskGroup()
    }
}

// MARK: - Presenter Output
extension HomePresenter: HomeInteractorOutput {
    
    func showCurrentUser(user: UserPresentation) {
        view.showCurrentUser(user: user)
    }
    
    func showPopularMovies(movies popularMovies: [Movies]) {
        let popularMoviesPresentation = popularMovies.map { PopularMoviesPresentation(movies: $0) }
        view.showPopularMovies(movies: popularMoviesPresentation)
    }
    
    func showGenres(genres: [Genre]) {
        let genresPresentation = genres.map { GenresPresentation(genre: $0) }
        view.showGenres(genres: genresPresentation)
    }
    
    func showTopRatedMovies(movies topRatedMovies: [Movies]) {
        let topRatedPresentation = topRatedMovies.map { TopRatedMoviesPresentation(movies: $0) }
        view.showTopRatedMovies(movies: topRatedPresentation)
    }
}
