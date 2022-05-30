//
//  ActorDetailsContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import MovieDB_Wrapper

protocol ActorDetailsInteractorProtocol: AnyObject {
    var delegate: ActorDetailsInteractorOutput? { get set }
    
    func loadActorServicesWithTaskGroup()
    func userDidSelectMovie(at indexPath: IndexPath)
}

protocol ActorDetailsInteractorOutput: AnyObject {
    func showActorDetails(details: People)
    func showActorMovies(movies: [Movies])
    func showMovieDetails(with movieID: Int)
}

protocol ActorDetailsPresenterProtocol: AnyObject {
    var actorViewModelCell: ActorViewModelCell { get set }
    
    func viewDidLoad()
    func userDidSelectMovie(at indexPath: IndexPath)
}

protocol ActorDetailsPresenterOutput: AnyObject {
    func showActorDetails()
    func showActorMovies()
}

protocol ActorDetailsRoute: AnyObject {
    func toMovieDetails(with movieID: Int)
}
