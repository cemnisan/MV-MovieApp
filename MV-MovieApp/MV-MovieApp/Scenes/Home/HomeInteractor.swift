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
    
    func loadCurrentUser() {
        fireStoreService.readUser { (result) in
            switch result {
            case .success(let user):
                self.delegate?.showCurrentUser(user: user)
            case .failure(let error):
                print(error)
            }
        }
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
    
    func loadHomeServicesWithTaskGroup() {
        Task {
            await withTaskGroup(of: Void.self, body: { group in
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
    
    func userDidSelectMovie() {
        delegate?.showMovieDetail()
    }
}

// MARK: - Results Helper
extension HomeInteractor {
    
    @MainActor private func popularMoviesResult(result: Result<PopularMovies>) {
        switch result {
        case .success(let popularMovies):
            self.popularMovies.append(contentsOf: popularMovies.results)
            delegate?.showPopularMovies(movies: self.popularMovies.lazy.map { $0 })
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor private func topRatedMoviesResult(result: Result<TopRatedMoviesResult>) {
        switch result {
        case .success(let topRatedMovies):
            self.topRatedMovies.append(contentsOf: topRatedMovies.results)
            delegate?.showTopRatedMovies(movies: self.topRatedMovies.lazy.map { $0 })
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor private func genresResult(result: Result<GenresResult>) {
        switch result {
        case .success(let genres):
            self.genres.append(contentsOf: genres.genres)
            delegate?.showGenres(genres: self.genres)
        case .failure(let error):
            print(error)
        }
    }
}
