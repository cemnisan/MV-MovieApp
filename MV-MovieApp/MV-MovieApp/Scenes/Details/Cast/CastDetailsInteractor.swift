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
    private var actorMovies: [Movies] = []
    
    init(peopleService: PeopleServiceableProtocol,
         currentCastID: String) {
        self.peopleService  = peopleService
        self.currentCastID  = currentCastID
    }
}

extension CastDetailsInteractor: CastDetailsInteractorProtocol {

    func loadActorServicesWithTaskGroup() {
        Task {
            await withTaskGroup(of: Void.self, body: { group in
                group.addTask(priority: .background) {
                    await self.loadCastDetails()
                }
                
                group.addTask(priority: .background) {
                    await self.loadActorMovies()
                }
            })
        }
    }
    
    func userDidSelectMovie(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0: break
        case 1:
            let movie = actorMovies[indexPath.row]
            delegate?.showMovieDetails(with: movie.id)
        default: break
        }
    }
}

// MARK: - Loader
extension CastDetailsInteractor {
    
    private func loadCastDetails() async  {
        let result = await peopleService.getPeopleDetails(with: currentCastID)
        await castDetailsResult(result: result)
    }
    
    private func loadActorMovies() async {
        let result = await peopleService.getPeopleMovies(with: currentCastID)
        await actorMoviesResult(result: result)
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
    
    @MainActor
    private func actorMoviesResult(result: Result<PeopleMovies>) {
        switch result {
        case .success(let actorMovies):
            self.actorMovies.append(contentsOf: actorMovies.cast)
            delegate?.showActorMovies(movies: self.actorMovies.lazy.map { $0 })
        case .failure(let error): print(error)
        }
    }
}
