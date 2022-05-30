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
    
    func loadCurrentUser() async
    func loadServicesWithTaskGroup()
    
    func userDidSelectItem(with indexPath: IndexPath)
}

// MARK: - Interactor Output
protocol HomeInteractorOutput: AnyObject {
    func showCurrentUser(user: UserPresentation)
    func showPopularMovies(movies popularMovies: [Movies])
    func showTopRatedMovies(movies topRatedMovies: [Movies])
    func showGenres(genres: [Genre])
    func showMovieDetail(with movieID: Int)
}

// MARK: - Presenter Protocol
protocol HomePresenterProtocol: AnyObject {
    var homeViewModelCell: HomeViewModelCell { get set }
    
    func viewDidLoad()
    func userDidSelectItem(with indexPath: IndexPath)
}

// MARK: - Presenter Output
protocol HomePresenterOutput: AnyObject {
    func showCurrentUser(user: UserPresentation)
    func showPopularMovies()
    func showTopRatedMovies()
    func showGenres()
}

// MARK: - Router Contracts
protocol HomeRoute: AnyObject {
    func toDetail(with movieID: Int)
}
