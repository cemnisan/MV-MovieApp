//
//  PopularMoviesPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import struct MovieDB_Wrapper.Movies

struct PopularMoviesPresentation: Hashable {
    let image: String?
    let title: String
    
    init(movies: Movies) {
        self.image = movies.backdropPath
        self.title = movies.title
    }
}
