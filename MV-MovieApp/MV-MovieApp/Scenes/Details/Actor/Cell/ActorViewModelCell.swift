//
//  ActorViewModelCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.05.2022.
//

import Foundation

struct ActorViewModelCell {
    var actorDetail: ActorDetailPresentation?
    var actorMovies: [MoviePresentation]?
    
    init(actorDetail: ActorDetailPresentation? = nil,
         actorMovies: [MoviePresentation]? = nil) {
        self.actorDetail = actorDetail
        self.actorMovies = actorMovies
    }
}
