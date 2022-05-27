//
//  SimilarMoviesPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 27.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.Movies

struct SimilarMoviesPresentation: Hashable {
    let movieTitle: String
    var movieBackgroundPath: String?
    
    init(movies: Movies) {
        self.movieTitle = movies.originalTitle
        self.movieBackgroundPath = movies.backdropPath
    }
}
