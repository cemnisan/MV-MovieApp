//
//  ActorDetailsInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation
import MovieDB_Wrapper

final class ActorDetailsInteractor {
    
    var delegate: ActorDetailsInteractorOutput?
    private let peopleService: PeopleServiceableProtocol
    
    private let currentActorID: String
    private var actorMovies: [Movies] = []
    private var actor: People?
    
    init(peopleService: PeopleServiceableProtocol,
         currentActorID: String) {
        self.peopleService  = peopleService
        self.currentActorID = currentActorID
    }
}

extension ActorDetailsInteractor: ActorDetailsInteractorProtocol {

    func loadActorServicesWithTaskGroup() {
        Task {
            await withTaskGroup(of: Void.self, body: { group in
                group.addTask(priority: .background) {
                    await self.loadActorDetails()
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
extension ActorDetailsInteractor {
    
    private func loadActorDetails() async  {
        let result = await peopleService.getPeopleDetails(with: currentActorID)
        await actorDetailsResult(result: result)
    }
    
    private func loadActorMovies() async {
        let result = await peopleService.getPeopleMovies(with: currentActorID)
        await actorMoviesResult(result: result)
    }
}

// MARK: - Result Helper
extension ActorDetailsInteractor {
    
    @MainActor
    private func actorDetailsResult(result: Result<People>) {
        switch result {
        case .success(let castDetails):
            self.actor = castDetails
            delegate?.showActorDetails(details: castDetails)
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
