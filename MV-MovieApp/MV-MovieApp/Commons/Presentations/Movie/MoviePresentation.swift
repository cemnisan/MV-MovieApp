//
//  MoviePresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 27.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.Movies

struct MoviePresentation: Hashable {
    let movieTitle: String
    var movieBackgroundPath: String?
    
    init(movie: Movies) {
        self.movieTitle = movie.originalTitle
        self.movieBackgroundPath = movie.backdropPath
    }
}