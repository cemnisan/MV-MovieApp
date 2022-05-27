//
//  MovieDetailPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.MovieDetail

struct MovieDetailPresentation {
    
    var moviePosterPath: String?
    var movieBackgroundPath: String?
    let movieTitle: String
    let movieVoteAverage: Double
    let movieReleaseDate: String
    let movieOverview: String
    
    init(detail: MovieDetail) {
        self.moviePosterPath     = detail.posterPath
        self.movieBackgroundPath = detail.backdropPath
        self.movieTitle          = detail.originalTitle
        self.movieVoteAverage    = detail.voteAverage
        self.movieReleaseDate    = detail.releaseDate
        self.movieOverview       = detail.overview
    }
}
