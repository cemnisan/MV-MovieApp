//
//  GenrePresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 19.05.2022.
//

import struct MovieDB_Wrapper.Genre

struct GenrePresentation: Hashable {
    let id: Int
    let name: String
    
    init(genre: Genre) {
        self.id   = genre.id
        self.name = genre.name
    }
    
    static func ==(rhs: GenrePresentation,
                   lhs: GenrePresentation) -> Bool {
        return rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
