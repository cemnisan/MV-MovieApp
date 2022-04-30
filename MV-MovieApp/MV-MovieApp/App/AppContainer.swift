//
//  AppContainer.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import Foundation
import MovieDB_Wrapper

let app = AppContainer()

final class AppContainer {
    let router  = AppRouter()
    let service = MovieService()
}
