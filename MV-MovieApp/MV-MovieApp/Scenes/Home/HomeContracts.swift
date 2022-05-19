//
//  HomeContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation
import MovieDB_Wrapper

// MARK: - Interactor Protocol
protocol HomeInteractorProtocol: AnyObject {
    var delegate: HomeInteractorOutput? { get set }
    
    func loadCurrentUser()
    func loadHomeServicesWithTaskGroup()
}

// MARK: - Interactor Output
protocol HomeInteractorOutput: AnyObject {
    func showCurrentUser(user: UserPresentation)
    func showPopularMovies(movies popularMovies: [Movies])
    func showTopRatedMovies(movies topRatedMovies: [Movies])
    func showGenres(genres: [Genre])
}

// MARK: - Presenter Protocol
protocol HomePresenterProtocol: AnyObject {
    func loadCurrentUser()
    func loadHomeServicesWithTaskGroup()
}

// MARK: - Presenter Output
protocol HomePresenterOutput: AnyObject {
    func showCurrentUser(user: UserPresentation)
    func showPopularMovies(movies popularMovies: [PopularMoviesPresentation])
    func showTopRatedMovies(movies topRatedMovies: [TopRatedMoviesPresentation])
    func showGenres(genres: [GenresPresentation])
}

// MARK: - Router Contracts
protocol HomeRouterProtocol: AnyObject {
    func navigate(to route: HomeRoute)
}

enum HomeRoute {
    case popularMoviesDetail(PopularMoviesPresentation)
    case topRatedMoviesDetail(TopRatedMoviesPresentation)
}
