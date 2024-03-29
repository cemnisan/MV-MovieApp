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
    func showCastDetail(with castID: String)
}

protocol MovieDetailPresenterProtocol: AnyObject {
    var detailsViewModelCell: DetailsViewModelCell { get set }
    
    func viewDidLoad()
    func userDidSelectItem(at indexPath: IndexPath)
}

protocol MovieDetailPresenterOutput: AnyObject {
    func showMovieDetail(movie: MovieDetailPresentation)
    func showCast()
    func showRelatedMovies()
}

protocol MovieDetailRoute: AnyObject {
    func toMovieDetail(with movieID: Int)
    func toCastDetail(with castID: String)
}
