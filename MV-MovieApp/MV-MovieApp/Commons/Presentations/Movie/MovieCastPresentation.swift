//
//  MovieCastPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 27.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.Cast

struct MovieCastPresentation: Hashable {
    let id = UUID()
    var castPosterPath: String?
    
    init(cast: Cast) {
        self.castPosterPath = cast.profilePath
    }
    
    static func ==(rhs: MovieCastPresentation,
                   lhs: MovieCastPresentation) -> Bool {
        return rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
