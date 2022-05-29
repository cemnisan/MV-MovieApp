//
//  CastDetailsInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import MovieDB_Wrapper

final class CastDetailsInteractor {
    
    var delegate: CastDetailsInteractorOutput?
    private let peopleService: PeopleServiceableProtocol
    
    private let currentCastID: String
    
    init(peopleService: PeopleServiceableProtocol,
         currentCastID: String) {
        self.peopleService  = peopleService
        self.currentCastID  = currentCastID
    }
}

extension CastDetailsInteractor: CastDetailsInteractorProtocol {
    
    func loadCastDetails() {
        Task {
            let result = await peopleService.getPeopleDetails(with: currentCastID)
            await castDetailsResult(result: result)
        }
    }
}

// MARK: - Result Helper
extension CastDetailsInteractor {
    
    @MainActor
    private func castDetailsResult(result: Result<People>) {
        switch result {
        case .success(let castDetails):
            delegate?.showCastDetails(details: castDetails)
        case .failure(let error): print(error)
        }
    }
}
