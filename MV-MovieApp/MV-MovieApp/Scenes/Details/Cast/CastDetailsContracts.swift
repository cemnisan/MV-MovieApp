//
//  CastDetailsContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import MovieDB_Wrapper

protocol CastDetailsInteractorProtocol: AnyObject {
    var delegate: CastDetailsInteractorOutput? { get set }
    
    func loadActorServicesWithTaskGroup()
    func userDidSelectMovie(at indexPath: IndexPath)
}

protocol CastDetailsInteractorOutput: AnyObject {
    func showCastDetails(details: People)
    func showActorMovies(movies: [Movies])
    func showMovieDetails(with movieID: Int)
}

protocol CastDetailsPresenterProtocol: AnyObject {
    func loadActorServicesWithTaskGroup()
    func userDidSelectMovie(at indexPath: IndexPath)
}

protocol CastDetailsPresenterOutput: AnyObject {
    func showCastDetails(details: ActorDetailPresentation)
    func showActorMovies(movies: [TopRatedMoviesPresentation])
}

protocol CastDetailsRoute: AnyObject {
    func toMovieDetails(with movieID: Int)
}
