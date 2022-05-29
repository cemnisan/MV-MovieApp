//
//  ActorDetailsPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import MovieDB_Wrapper

final class ActorDetailsPresenter {
    
    var actorViewModelCell = ActorCellViewModel()
    
    private unowned var view: ActorDetailsPresenterOutput
    private let interactor: ActorDetailsInteractorProtocol
    private let router: ActorDetailsRoute
    
    init(view: ActorDetailsPresenterOutput,
         interactor: ActorDetailsInteractorProtocol,
         router: ActorDetailsRoute) {
        self.view           = view
        self.interactor     = interactor
        self.router         = router
        interactor.delegate = self
    }
}

extension ActorDetailsPresenter: ActorDetailsPresenterProtocol {
    
    func viewDidLoad() {
        interactor.loadActorServicesWithTaskGroup()
    }
    
    func userDidSelectMovie(at indexPath: IndexPath) {
        interactor.userDidSelectMovie(at: indexPath)
    }
}

extension ActorDetailsPresenter: ActorDetailsInteractorOutput {
    
    func showActorMovies(movies: [Movies]) {
        actorViewModelCell.actorMovies = movies.map { TopRatedMoviesPresentation(movies: $0) }
        view.showActorMovies()
    }
    
    func showActorDetails(details: People) {
        actorViewModelCell.actorDetail = ActorDetailPresentation(people: details)
        view.showActorDetails()
    }
        
    func showMovieDetails(with movieID: Int) {
        router.toMovieDetails(with: movieID)
    }
}
