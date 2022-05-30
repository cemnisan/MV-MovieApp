//
//  HomeInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation
import MovieDB_Wrapper

final class HomeInteractor {
    
    weak var delegate: HomeInteractorOutput?
    private let moviesService: MoviesServiceable
    private let genresService: GenresServiceable
    private let fireStoreService: GoogleFireStoreService
    
    private var popularMoviesPageNumber  = 1
    private var topRatedMoviesPageNumber = 1
    
    private var popularMovies            = [Movies]()
    private var topRatedMovies           = [Movies]()
    private var genres                   = [Genre]()
    
    init(moviesService: MoviesServiceable,
         genresService: GenresServiceable,
         fireStoreService: GoogleFireStoreService) {
        self.moviesService    = moviesService
        self.genresService    = genresService
        self.fireStoreService = fireStoreService
    }
}

// MARK: - Home Interactor Protocol
extension HomeInteractor: HomeInteractorProtocol {
    
    private func loadCurrentUserToAsync() async -> Result<UserPresentation> {
        return await withCheckedContinuation({ continuation in
            fireStoreService.readUser { (result) in
                continuation.resume(returning: result)
            }
        })
    }
    
    func loadCurrentUser() async {
        let result = await loadCurrentUserToAsync()
        await currentUserResult(result: result)
    }
    
    private func loadPopularMovies() async {
        let result = await moviesService.getPopularMovies(
            language: nil,
            pageNumber: popularMoviesPageNumber,
            region: nil)
        await popularMoviesResult(result: result)
    }
    
    private func loadGenres() async {
        let result = await genresService.getMovieGenres(language: nil)
        await genresResult(result: result)
    }
    
    private func loadTopRatedMovies() async {
        let result = await moviesService.getTopRatedMovies(
            language: nil,
            pageNumber: topRatedMoviesPageNumber,
            region: nil)
        await topRatedMoviesResult(result: result)
    }
    
    func loadServicesWithTaskGroup() {
        Task {
            await withTaskGroup(of: Void.self, body: { group in
                group.addTask(priority: .background) {
                    await self.loadCurrentUser()
                }
                
                group.addTask(priority: .background) {
                    await self.loadPopularMovies()
                }
                
                group.addTask(priority: .background) {
                    await self.loadGenres()
                }
                
                group.addTask(priority: .background) {
                    await self.loadTopRatedMovies()
                }
            })
        }
    }
    
    func userDidSelectItem(with indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let movieID = popularMovies[indexPath.row].id
            delegate?.showMovieDetail(with: movieID)
        case 2:
            let movieID = topRatedMovies[indexPath.row].id
            delegate?.showMovieDetail(with: movieID)
        default: break
        }
    }
}

// MARK: - Results Helper
extension HomeInteractor {
    
    @MainActor
    private func currentUserResult(result: Result<UserPresentation>) {
        switch result {
        case .success(let user):
            delegate?.showCurrentUser(user: user)
        case .failure(let error): print(error)
        }
    }
    
    @MainActor
    private func popularMoviesResult(result: Result<PopularMovies>) {
        switch result {
        case .success(let popularMovies):
            self.popularMovies.append(contentsOf: popularMovies.results)
            delegate?.showPopularMovies(movies: self.popularMovies.lazy.map { $0 })
        case .failure(let error): print(error)
        }
    }
    
    @MainActor
    private func topRatedMoviesResult(result: Result<TopRatedMoviesResult>) {
        switch result {
        case .success(let topRatedMovies):
            self.topRatedMovies.append(contentsOf: topRatedMovies.results)
            delegate?.showTopRatedMovies(movies: self.topRatedMovies.lazy.map { $0 })
        case .failure(let error): print(error)
        }
    }
    
    @MainActor
    private func genresResult(result: Result<GenresResult>) {
        switch result {
        case .success(let genres):
            self.genres.append(contentsOf: genres.genres)
            delegate?.showGenres(genres: self.genres)
        case .failure(let error): print(error)
        }
    }
}
