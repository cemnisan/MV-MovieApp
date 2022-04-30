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
 
    private var popularMovies  = [Movies]()
    private var topRatedMovies = [Movies]()
    
    init(moviesService: MoviesServiceable) {
        self.moviesService = moviesService
    }
}

// MARK: - Home Interactor Protocol
extension HomeInteractor: HomeInteractorProtocol {
    
    func loadPopularMovies() async {
        delegate?.handleOutput(.setLoading(true))
        let result = await moviesService.getPopularMovies(language: nil,
                                                          pageNumber: 1,
                                                          region: nil)
        delegate?.handleOutput(.setLoading(false))
        
        await popularMoviesResult(result: result)
    }
    
    func loadTopRatedMovies() async {
        delegate?.handleOutput(.setLoading(true))
        let result = await moviesService.getTopRatedMovies(language: nil,
                                                           pageNumber: 1,
                                                           region: nil)
        delegate?.handleOutput(.setLoading(false))
        
        await topRatedMoviesResult(result: result)
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
            delegate?.handleOutput(.showTopRatedMovies(self.topRatedMovies))
        case .failure(let error):
            print(error)
        }
    }
}
