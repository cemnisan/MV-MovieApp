//
//  ActorDetailPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 29.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.People

struct ActorDetailPresentation: Hashable {
    var actorPosterPath: String?
    let actorName: String
    var actorBorn: String?
    let actorBio: String
    
    init(people: People) {
        self.actorPosterPath = people.profilePath
        self.actorName       = people.name
        self.actorBorn       = people.placeOfBirth
        self.actorBio        = people.biography
    }
}
