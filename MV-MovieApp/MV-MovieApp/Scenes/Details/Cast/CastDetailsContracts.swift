//
//  CastDetailsContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import struct MovieDB_Wrapper.People

protocol CastDetailsInteractorProtocol: AnyObject {
    var delegate: CastDetailsInteractorOutput? { get set }
    
    func loadCastDetails()
}

protocol CastDetailsInteractorOutput: AnyObject {
    func showCastDetails(details: People)
}

protocol CastDetailsPresenterProtocol: AnyObject {
    func loadCastDetail()
}

protocol CastDetailsPresenterOutput: AnyObject {
    func showCastDetails(details: ActorDetailPresentation)
}

protocol CastDetailsRoute: AnyObject { }
