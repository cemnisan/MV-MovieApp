//
//  File.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import Foundation
import MovieDB_Wrapper

final class MovieDetailInteractor {
    
    weak var delegate: MovieDetailInteractorOutput?

    private let movieService: MoviesServiceable
    private let currentMovieID: Int!
    
    private var movieCast: [Cast]        = []
    private var similarMovies: [Movies]  = []
    
    private var pageCountOfSimilarMovies = 1
    
    init(movieService: MoviesServiceable,
         currentMovieID: Int) {
        self.movieService   = movieService
        self.currentMovieID = currentMovieID
    }
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    private func loadMovieDetail() async {
        if let movieID = currentMovieID {
            let result = await movieService.getMovieDetails(
                id: movieID,
                language: nil,
                appendToResponse: nil)
            await movieDetailResult(result: result)
        }
    }
    
    private func loadCast() async {
        if let movieID = currentMovieID {
            let result = await movieService.getMovieCredits(
                id: movieID,
                language: "en-US")
            await movieCastResult(result: result)
        }
    }
    
    private func loadRelatedMovies() async {
        if let movieID = currentMovieID {
            let result = await movieService.getSimilarMovies(
                id: movieID,
                language: nil,
                pageNumber: pageCountOfSimilarMovies)
            await similarMoviesResult(result: result)
        }
    }
    
    func loadMovieServicesWithTaskgroup() {
        Task {
            await withTaskGroup(of: Void.self, body: { group in
                group.addTask(priority: .background) {
                    await self.loadMovieDetail()
                }
                
                group.addTask(priority: .background) {
                    await self.loadCast()
                }
                
                group.addTask(priority: .background) {
                    await self.loadRelatedMovies()
                }
            })
        }
    }
}

extension MovieDetailInteractor {
    
    @MainActor
    private func movieDetailResult(result: Result<MovieDetail>) {
        switch result {
        case .success(let movieDetail):
            delegate?.showMovieDetail(movie: movieDetail)
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    private func movieCastResult(result: Result<MovieCredits>) {
        switch result {
        case .success(let movieCast):
            self.movieCast = movieCast.cast
            delegate?.showCast(cast: self.movieCast.lazy.map { $0 })
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    private func similarMoviesResult(result: Result<SimilarMovies>) {
        switch result {
        case .success(let similarMovies):
            self.similarMovies = similarMovies.results!
            delegate?.showRelatedMovies(movies: self.similarMovies.lazy.map { $0 })
        case .failure(let error):
            print(error)
        }
    }
}
