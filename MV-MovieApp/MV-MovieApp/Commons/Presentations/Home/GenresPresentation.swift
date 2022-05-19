//
//  GenresPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 19.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.Genre

struct GenresPresentation: Hashable {
    let id: Int
    let name: String
    
    init(genre: Genre) {
        self.id   = genre.id
        self.name = genre.name
    }
}
