//
//  CastDetailsViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit
import MV_Components

struct ActorCells: Hashable {
    let image: UIImage
    
    static let actors: [ActorCells] = [ActorCells(image: UIImage(named: "actor")!)]
    static let actorMovies: [ActorCells] = [
        ActorCells(image: #imageLiteral(resourceName: "movie2")),
        ActorCells(image: #imageLiteral(resourceName: "movie")),
        ActorCells(image: #imageLiteral(resourceName: "exam")),
        ActorCells(image: #imageLiteral(resourceName: "home")),
        ActorCells(image: #imageLiteral(resourceName: "left-arrow")),
    ]
}

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<CastSection, AnyHashable>
fileprivate typealias Snapshot   = NSDiffableDataSourceSnapshot<CastSection, AnyHashable>

final class CastDetailsViewController: BaseViewController {
    
    private var castCollectionView: UICollectionView! = nil
    private var castDataSource: DataSource!           = nil
    
    var castDetailsPresenter: CastDetailsPresenterProtocol!
    
    var actorDetails: ActorDetailPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        castDetailsPresenter.loadCastDetail()
    }
}

// MARK: - Configure
extension CastDetailsViewController {
    
    private func configure() {
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: GenerateLayout.generateCastLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor  = K.Styles.backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellType: ActorCell.self)
        collectionView.register(cellType: TopRatedCell.self)
        collectionView.register(cellType: MVHeaderView.self, sectionHeader: K.Home.sectionHeader)
        collectionView.configureConstraints(
            top: (view.topAnchor, 0),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, -16),
            bottom: (view.bottomAnchor, 0))
        castCollectionView = collectionView
    }
    
    private func configureDataSource() {
        castDataSource = DataSource(collectionView: castCollectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             item: AnyHashable) -> UICollectionViewCell? in
            let sectionType = CastSection.allCases[indexPath.section]
            
            switch sectionType {
            case .actorName:
                let cell  = collectionView.dequeView(cellType: ActorCell.self,
                                                     indexPath: indexPath)
                if let actorPresentation = self.actorDetails { cell.set(with: actorPresentation) }
                return cell
            case .actorMovies:
                let cell = collectionView.dequeView(cellType: TopRatedCell.self,
                                                    indexPath: indexPath)
                let actorMovie = ActorCells.actorMovies[indexPath.row]
                cell.set(with: actorMovie.image)
                return cell
            case .actorTVSeries: return UICollectionViewCell()
            }
        }
        
        castDataSource.supplementaryViewProvider = {
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
        castDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotCurrentState() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([CastSection.actorName])
        snapshot.appendItems([actorDetails])
        
        snapshot.appendSections([CastSection.actorMovies])
        snapshot.appendItems(ActorCells.actorMovies)
        return snapshot
    }
}

extension CastDetailsViewController: CastDetailsPresenterOutput {
    func showCastDetails(details: ActorDetailPresentation) {
        self.actorDetails = details
        configureDataSource()
    }
}
