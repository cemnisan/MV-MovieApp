//
//  HomeViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit
import MV_Components

struct PopularCarouselData: Hashable {
    let image: UIImage?
    let text: String
    
    static let data = [
        PopularCarouselData(image: #imageLiteral(resourceName: "movie23"), text: "Lorem ipsum"),
        PopularCarouselData(image: #imageLiteral(resourceName: "movie3"), text: "Lorem ipsum1"),
        PopularCarouselData(image: #imageLiteral(resourceName: "movie23"), text: "Lorem ipsum2"),
        PopularCarouselData(image: #imageLiteral(resourceName: "movie3"), text: "Lorem ipsum3"),
    ]
}

final class HomeViewController: UIViewController {
    
    static let sectionHeader = "section-header"
    
    private enum Section: String, CaseIterable {
        case popular  = "Popular"
        case category = "Category"
        case discover = "Discover Movie"
    }
    
    private let userPicture  = MVUserImage(cornerRadius: 25)
    private let userUsername = MVTitleLabel(
        textAlignment: .left,
        fontSize: 18,
        textColor: .white)
    private let homeDescription = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 16,
        textColor: #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.6156862745, alpha: 1),
        text: "Let’s stream your favorite movie")
    private let popularMoviesLabel = MVTitleLabel(
        textAlignment: .left,
        fontSize: 20,
        textColor: .white)
    private let searchTextField = MVTextField(placeHolder: "🔍 Search a title...")
    private let searchFilterButton = MVButton(image: UIImage(named: "filter")!)
    private var moviesCollectionView: UICollectionView! = nil
    private var moviesDataSource: UICollectionViewDiffableDataSource<Section, PopularCarouselData>! = nil
    
    // MARK: - Properties
    var homePresenter: HomePresenter!
    
    private var carouselData = [PopularCarouselData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Configure
extension HomeViewController {
    
    private func configure() {
        configureViewController()
        configureUserPicture()
        configureUserUsername()
        configureHomeDescription()
        configureSearchTextField()
        configureSearchFilterButton()
        configureMoviesCollectionView()
        configureDataSource()
    }
    
    private func configureViewController() {
        view.backgroundColor = K.Styles.backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureUserPicture() {
        view.addSubview(userPicture)
        userPicture.image = #imageLiteral(resourceName: "profilePic")
        userPicture.configureConstraints(
            top: (view.safeAreaLayoutGuide.topAnchor, 16),
            leading: (view.leadingAnchor, 24))
        userPicture.configureHeight(height: 50)
        userPicture.configureWidth(width: 50)
    }
    
    private func configureUserUsername() {
        view.addSubview(userUsername)
        userUsername.text = "Hello, Cem Nisan"
        userUsername.configureConstraints(
            top: (userPicture.topAnchor, 4),
            leading: (userPicture.trailingAnchor, 16),
            trailing: (view.trailingAnchor, -16))
        userUsername.configureHeight(height: 20)
    }
    
    private func configureHomeDescription() {
        view.addSubview(homeDescription)
        homeDescription.configureConstraints(
            leading: (userPicture.trailingAnchor, 16),
            trailing: (view.trailingAnchor, -16),
            bottom: (userPicture.bottomAnchor, -4))
        homeDescription.configureHeight(height: 15)
    }
    
    private func configureSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.layer.cornerRadius = 22
        searchTextField.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1568627451, blue: 0.2117647059, alpha: 1)
        searchTextField.configureConstraints(
            top: (userPicture.bottomAnchor, 32),
            leading: (view.leadingAnchor, 24),
            trailing: (view.trailingAnchor, -24))
        searchTextField.configureHeight(height: 45)
    }
    
    private func configureSearchFilterButton() {
        view.addSubview(searchFilterButton)
        searchFilterButton.addTarget(
            self,
            action: #selector(searchFilterButtonTapped),
            for: .touchUpInside)
        searchFilterButton.configureConstraints(
            trailing: (searchTextField.trailingAnchor, -16),
            centerY: (searchTextField.centerYAnchor, 0))
        searchFilterButton.configureWidth(width: 20)
        searchFilterButton.configureHeight(height: 20)
    }
    
    private func configureMoviesCollectionView() {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor  = K.Styles.backgroundColor
        collectionView.delegate         = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            PopularCell.self,
            forCellWithReuseIdentifier: PopularCell.cellID)
        collectionView.register(
            MVHeaderView.self,
            forSupplementaryViewOfKind: HomeViewController.sectionHeader,
            withReuseIdentifier: MVHeaderView.identifier)
        collectionView.configureConstraints(
            top: (searchTextField.bottomAnchor, 24),
            leading: (view.leadingAnchor, 0),
            trailing: (view.trailingAnchor, 0),
            bottom: (view.bottomAnchor, 0))
        moviesCollectionView = collectionView
    }
    
    private func configureDataSource() {
        moviesDataSource = UICollectionViewDiffableDataSource<Section, PopularCarouselData>(collectionView: moviesCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: PopularCarouselData) -> UICollectionViewCell? in
            let sectionType = Section.allCases[indexPath.section]
            
            switch sectionType {
            case .popular:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PopularCell.cellID,
                    for: indexPath) as! PopularCell
                cell.set(image: PopularCarouselData.data[indexPath.row].image,
                         text: "")
                return cell
            case .category: return UICollectionViewCell()
            case .discover: return UICollectionViewCell()
            }
        }
        
        moviesDataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView,
             kind: String,
             indexPath: IndexPath) -> UICollectionReusableView? in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MVHeaderView.identifier,
                for: indexPath) as? MVHeaderView else { fatalError() }
            supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
            
            return supplementaryView
        }
        
        let snapshot = snapshotCurrentState()
        moviesDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotCurrentState() -> NSDiffableDataSourceSnapshot<Section, PopularCarouselData> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PopularCarouselData>()
        snapshot.appendSections([Section.popular])
        snapshot.appendItems(PopularCarouselData.data)
        
        return snapshot
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout
        { (sectionIndex: Int,
           layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment
                .container
                .effectiveContentSize.width > 500
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .popular: return self.generatePopularMoviesLayout(isWide: isWideView)
            case .category: return nil
            case .discover: return nil
            }
        }
        return layout
    }
    
    private func generatePopularMoviesLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.7/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth  = isWide ? 0.475 : 0.85
        let groupFractionalHeight: CGFloat = isWide ? 1/3 : 1.5/3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 24,
            bottom: 5,
            trailing: 5)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HomeViewController.sectionHeader,
            alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

// MARK: - Button Tapped
extension HomeViewController {
    
    @objc
    private func searchFilterButtonTapped() {}
}

extension HomeViewController: UICollectionViewDelegate {}

// MARK: - HomeView Protocol
extension HomeViewController: HomeViewProtocol {
    func handleOutput(_ output: HomePresenterOutput) {}
}

