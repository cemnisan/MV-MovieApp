//
//  HomeContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation
import struct MovieDB_Wrapper.Movies

// MARK: - Interactor Contracts
protocol HomeInteractorProtocol: AnyObject {
    var delegate: HomeInteractorDelegate? { get set }
    
    func loadPopularMovies() async
    func loadTopRatedMovies() async
    
    func increasePageNumber(from movies: HomeMovies)
}

protocol HomeInteractorDelegate: AnyObject {
    func handleOutput(_ output: HomeInteractorOutput)
}

enum HomeInteractorOutput {
    case setPopularMoviesLoading(Bool)
    case setTopRatedMoviesLoading(Bool)
    case showPopularMovies([Movies])
    case showTopRatedMovies([Movies])
}

// MARK: - Presenter Contracts
protocol HomePresenterProtocol: AnyObject {
    func loadPopularMovies() async
    func loadTopRatedMovies() async
    
    func increasePageNumber(from movies: HomeMovies)
}

protocol HomeViewProtocol: AnyObject {
    func handleOutput(_ output: HomePresenterOutput)
}

enum HomePresenterOutput {
    case setPopularMoviesLoading(Bool)
    case setTopRatedMoviesLoading(Bool)
    case showPopularMovies([PopularMoviesPresentation])
    case showTopRatedMovies([TopRatedMoviesPresentation])
}

// MARK: - Router Contracts
protocol HomeRouterProtocol: AnyObject {
    func navigate(to route: HomeRoute)
}

enum HomeRoute {
    case popularMoviesDetail(PopularMoviesPresentation)
    case topRatedMoviesDetail(TopRatedMoviesPresentation)
}
