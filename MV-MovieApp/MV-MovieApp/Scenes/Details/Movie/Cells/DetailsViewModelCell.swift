//
//  DetailsViewModelCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.05.2022.
//

import Foundation

struct DetailsViewModelCell {
    var similarMovies: [MoviePresentation]?
    var movieCast: [MovieCastPresentation]?
    
    init(similarMovies: [MoviePresentation]? = nil,
         movieCast: [MovieCastPresentation]? = nil) {
        self.similarMovies = similarMovies
        self.movieCast     = movieCast
    }
}
