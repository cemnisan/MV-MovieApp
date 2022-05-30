//
//  ActorDetailsViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit
import MV_Components

final class ActorDetailsViewController: BaseViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<CastSection, AnyHashable>
    private typealias Snapshot   = NSDiffableDataSourceSnapshot<CastSection, AnyHashable>
    
    private var actorCollectionView: UICollectionView! = nil
    private var actorDataSource: DataSource!           = nil
    
    var actorDetailsPresenter: ActorDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        actorDetailsPresenter.viewDidLoad()
    }
}

// MARK: - Configure
extension ActorDetailsViewController {
    
    private func configure() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: GenerateLayout.generateCastLayout())
        view.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor  = K.Styles.backgroundColor
        collectionView.delegate         = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellType: ActorCell.self)
        collectionView.register(cellType: TopRatedCell.self)
        collectionView.register(cellType: MVHeaderView.self,
                                sectionHeader: K.Home.sectionHeader)
        collectionView.configureConstraints(
            top: (view.topAnchor, 0),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, -16),
            bottom: (view.bottomAnchor, 0))
        actorCollectionView = collectionView
    }
    
    private func configureDataSource() {
        actorDataSource = DataSource(collectionView: actorCollectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             item: AnyHashable) -> UICollectionViewCell? in
            let sectionType = CastSection.allCases[indexPath.section]
            
            switch sectionType {
            case .actor:
                let cell = collectionView.dequeView(cellType: ActorCell.self,
                                                    indexPath: indexPath)
                if let actorPresentation = item as? ActorDetailPresentation { cell.set(with: actorPresentation) }
                return cell
            case .actorMovies:
                let cell = collectionView.dequeView(cellType: TopRatedCell.self,
                                                    indexPath: indexPath)
                if let actorMovie = item as? MoviePresentation { cell.set(with: actorMovie) }
                return cell
            }
        }
        
        actorDataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView,
             kind: String,
             indexPath: IndexPath) -> UICollectionReusableView? in
            let supplementaryView = collectionView.dequeView(
                cellType: MVHeaderView.self,
                kind: kind,
                indexPath: indexPath)
            supplementaryView.label.text = CastSection.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        let snapshot = snapshotCurrentState()
        actorDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotCurrentState() -> Snapshot {
        let actorDetail = actorDetailsPresenter
            .actorViewModelCell
            .actorDetail
        let actorMovies = actorDetailsPresenter
            .actorViewModelCell
            .actorMovies ?? []
        var snapshot    = Snapshot()
        snapshot.appendSections([CastSection.actor])
        snapshot.appendItems([actorDetail])
        
        snapshot.appendSections([CastSection.actorMovies])
        snapshot.appendItems(actorMovies)
        return snapshot
    }
}

extension ActorDetailsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        actorDetailsPresenter.userDidSelectMovie(at: indexPath)
    }
}

extension ActorDetailsViewController: ActorDetailsPresenterOutput {
    
    func showActorDetails() {
        configureDataSource()
    }
    
    func showActorMovies() {
        configureDataSource()
    }
}
