//
//  TopRatedMoviesPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import struct MovieDB_Wrapper.Movies

struct TopRatedMoviesPresentation: Hashable {
    let title: String
    let image: String?
    let rating: Double
    let date: String?
    
    init(movies: Movies) {
        self.title  = movies.title
        self.image  = movies.posterPath
        self.rating = movies.voteAverage
        self.date   = movies.releaseDate
    }
}
