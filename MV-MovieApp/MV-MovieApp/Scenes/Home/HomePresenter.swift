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
    private let router: HomeRoute
        
    var homeViewModelCell = HomeViewModelCell()
    
    init(view: HomePresenterOutput,
         interactor: HomeInteractorProtocol,
         router: HomeRoute) {
        self.view                = view
        self.interactor          = interactor
        self.router              = router
        
        self.interactor.delegate = self
    }
}

// MARK: - Presenter Protocol
extension HomePresenter: HomePresenterProtocol {
    
    func loadCurrentUser() {
        Task(priority: .background) { await interactor.loadCurrentUser() }
    }
    
    func viewDidLoad() {
        interactor.loadServicesWithTaskGroup()
    }
    
    func userDidSelectItem(with indexPath: IndexPath) {
        interactor.userDidSelectItem(with: indexPath)
    }
}

// MARK: - Presenter Output
extension HomePresenter: HomeInteractorOutput {
    
    func showCurrentUser(user: UserPresentation) {
        view.showCurrentUser(user: user)
    }
    
    func showPopularMovies(movies popularMovies: [Movies]) {
        homeViewModelCell.popularMovies = popularMovies.map { MoviePresentation(movie: $0) }
        view.showPopularMovies()
    }
    
    func showGenres(genres: [Genre]) {
        homeViewModelCell.categoryOfMovies = genres.map { GenrePresentation(genre: $0) }
        view.showGenres()
    }
    
    func showTopRatedMovies(movies topRatedMovies: [Movies]) {
        homeViewModelCell.topRatedMovies = topRatedMovies.map { MoviePresentation(movie: $0) }
        view.showTopRatedMovies()
    }
    
    func showMovieDetail(with movieID: Int) {
        router.toDetail(with: movieID)
    }
}
