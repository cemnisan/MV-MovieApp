//
//  ActorCellViewModel.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.05.2022.
//

import Foundation

struct ActorCellViewModel: Hashable {
    var actorDetail: ActorDetailPresentation?
    var actorMovies: [TopRatedMoviesPresentation]?
    
    init(actorDetail: ActorDetailPresentation? = nil,
         actorMovies: [TopRatedMoviesPresentation]? = nil) {
        self.actorDetail = actorDetail
        self.actorMovies = actorMovies
    }
}
