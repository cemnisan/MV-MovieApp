//
//  HomePresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation

final class HomePresenter {
    
    private unowned let view: HomeViewProtocol
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    
    init(view: HomeViewProtocol,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol)
    {
        self.view                = view
        self.interactor          = interactor
        self.router              = router
        
        self.interactor.delegate = self
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func loadPopularMovies() async {
        await interactor.loadPopularMovies()
    }
    
    func loadTopRatedMovies() async {
        await interactor.loadTopRatedMovies()
    }
    
    func increasePageNumber(from movies: HomeMovies) {
        interactor.increasePageNumber(from: movies)
    }
}

extension HomePresenter: HomeInteractorDelegate {
    
    func handleOutput(_ output: HomeInteractorOutput) {
        switch output {
        case .setPopularMoviesLoading(let isLoading):
            view.handleOutput(.setPopularMoviesLoading(isLoading))
            
        case .showPopularMovies(let popularMovies):
            let popularMoviesPresentation = popularMovies.map { PopularMoviesPresentation(movies: $0) }
            view.handleOutput(.showPopularMovies(popularMoviesPresentation))
            
        case .setTopRatedMoviesLoading(let isLoading):
            view.handleOutput(.setTopRatedMoviesLoading(isLoading))
            
        case .showTopRatedMovies(let topRatedMovies):
            let topRatedMoviesPresentation = topRatedMovies.map { TopRatedMoviesPresentation(movies: $0) }
            view.handleOutput(.showTopRatedMovies(topRatedMoviesPresentation))
        }
    }
}
