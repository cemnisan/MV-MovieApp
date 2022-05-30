//
//  MoviePresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 27.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.Movies

struct MoviePresentation: Hashable {
    let id = UUID()
    let movieTitle: String
    var movieBackgroundPath: String?
    var moviePosterPath: String?
    let voteAverage: Double
    var releaseDate: String?
    
    init(movie: Movies) {
        self.movieTitle          = movie.originalTitle
        self.movieBackgroundPath = movie.backdropPath
        self.moviePosterPath     = movie.posterPath
        self.voteAverage         = movie.voteAverage
        self.releaseDate         = movie.releaseDate
    }
    
    static func ==(rhs: MoviePresentation,
                   lhs: MoviePresentation) -> Bool {
        return rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
