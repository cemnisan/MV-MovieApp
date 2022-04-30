//
//  PopularMoviesPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation
import struct MovieDB_Wrapper.Movies

struct PopularMoviesPresentation {
    let image: String?
    let title: String
    
    init(movies: Movies) {
        self.image = movies.posterPath
        self.title = movies.title
    }
}
