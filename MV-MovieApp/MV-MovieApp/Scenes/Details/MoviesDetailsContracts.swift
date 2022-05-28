//
//  MoviesDetailsContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import Foundation
import MovieDB_Wrapper

protocol MovieDetailInteractorProtocol: AnyObject {
    var delegate: MovieDetailInteractorOutput? { get set }
    
    func loadMovieServicesWithTaskgroup()
    func userDidSelectItem(at indexPath: IndexPath)
}

protocol MovieDetailInteractorOutput: AnyObject {
    func showMovieDetail(movie: MovieDetail)
    func showCast(cast: [Cast])
    func showRelatedMovies(movies: [Movies])
    func showMovieDetail(with movieID: Int)
}

protocol MovieDetailPresenterProtocol: AnyObject {
    func loadMovieServiceWithTaskgroup()
    func userDidSelectItem(at indexPath: IndexPath)
}

protocol MovieDetailPresenterOutput: AnyObject {
    func showMovieDetail(movie: MovieDetailPresentation)
    func showCast(cast: [MovieCastPresentation])
    func showRelatedMovies(movies: [MoviePresentation])
}

protocol MovieDetailRoute: AnyObject {
    func toDetail(with movieID: Int)
}
