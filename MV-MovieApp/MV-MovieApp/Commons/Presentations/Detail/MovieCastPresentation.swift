//
//  MovieCastPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 27.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.Cast

struct MovieCastPresentation: Hashable {
    var castPosterPath: String?
    
    init(cast: Cast) {
        self.castPosterPath = cast.profilePath
    }
}
