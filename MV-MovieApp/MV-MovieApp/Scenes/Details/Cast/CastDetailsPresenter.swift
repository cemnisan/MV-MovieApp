//
//  CastDetailsPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import MovieDB_Wrapper

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
    
    func loadActorServicesWithTaskGroup() {
        interactor.loadActorServicesWithTaskGroup()
    }
    
    func userDidSelectMovie(at indexPath: IndexPath) {
        interactor.userDidSelectMovie(at: indexPath)
    }
}

extension CastDetailsPresenter: CastDetailsInteractorOutput {
    
    func showCastDetails(details: People) {
        let actorDetailPresentation = ActorDetailPresentation(people: details)
        view.showCastDetails(details: actorDetailPresentation)
    }
    
    func showActorMovies(movies: [Movies]) {
        let moviesPresentation = movies.map { TopRatedMoviesPresentation(movies: $0) }
        view.showActorMovies(movies: moviesPresentation)
    }
    
    func showMovieDetails(with movieID: Int) {
        router.toMovieDetails(with: movieID)
    }
}
