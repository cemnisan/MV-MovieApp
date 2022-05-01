//
//  HomeInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation
import MovieDB_Wrapper

final class HomeInteractor {
    
    weak var delegate: HomeInteractorDelegate?
    private let moviesService: MoviesServiceable
 
    private var popularMoviesPageNumber  = 1
    private var topRatedMoviesPageNumber = 1
    
    private var popularMovies            = [Movies]()
    private var topRatedMovies           = [Movies]()
    
    init(moviesService: MoviesServiceable) {
        self.moviesService = moviesService
    }
}

// MARK: - Home Interactor Protocol
extension HomeInteractor: HomeInteractorProtocol {
    
    func loadPopularMovies() async {
        delegate?.handleOutput(.setPopularMoviesLoading(true))
        let result = await moviesService.getPopularMovies(language: nil,
                                                          pageNumber: popularMoviesPageNumber,
                                                          region: nil)
        delegate?.handleOutput(.setPopularMoviesLoading(false))
        
        await popularMoviesResult(result: result)
    }
    
    func loadTopRatedMovies() async {
        delegate?.handleOutput(.setTopRatedMoviesLoading(true))
        let result = await moviesService.getTopRatedMovies(language: nil,
                                                           pageNumber: topRatedMoviesPageNumber,
                                                           region: nil)
        delegate?.handleOutput(.setTopRatedMoviesLoading(false))
        
        await topRatedMoviesResult(result: result)
    }
    
    func increasePageNumber(from movies: HomeMovies) {
        switch movies {
        case .popular:
            popularMoviesPageNumber  += 1
        case .topRated:
            topRatedMoviesPageNumber += 1
        }
    }
}

// MARK: - Results Helper
extension HomeInteractor {
    
    @MainActor private func popularMoviesResult(result: Result<PopularMovies>) {
        switch result {
        case .success(let popularMovies):
            self.popularMovies.append(contentsOf: popularMovies.results)
            delegate?.handleOutput(.showPopularMovies(self.popularMovies.lazy.map { $0 }))
            
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor private func topRatedMoviesResult(result: Result<TopRatedMoviesResult>) {
        switch result {
        case .success(let topRatedMovies):
            self.topRatedMovies.append(contentsOf: topRatedMovies.results)
            delegate?.handleOutput(.showTopRatedMovies(self.topRatedMovies.lazy.map { $0 }))
            
        case .failure(let error):
            print(error)
        }
    }
}
