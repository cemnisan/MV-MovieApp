//
//  HomeViewModelCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.05.2022.
//

import Foundation

struct HomeViewModelCell {
    var popularMovies: [MoviePresentation]?
    var categoryOfMovies: [GenrePresentation]?
    var topRatedMovies: [MoviePresentation]?
    
    init(popularMovies: [MoviePresentation]?    = nil,
         categoryOfMovies: [GenrePresentation]? = nil,
         topRatedMovies: [MoviePresentation]?   = nil) {
        self.popularMovies    = popularMovies
        self.categoryOfMovies = categoryOfMovies
        self.topRatedMovies   = topRatedMovies
    }
}
