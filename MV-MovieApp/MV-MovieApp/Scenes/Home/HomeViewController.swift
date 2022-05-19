//
//  HomeViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit
import MV_Components

final class HomeViewController: UIViewController {
    
    private let userPicture  = MVUserImage(cornerRadius: 25)
    private let userFullname = MVTitleLabel(
        textAlignment: .left,
        fontSize: 18,
        textColor: .white)
    private let homeDescription = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 16,
        textColor: K.Styles.globalColor,
        text: K.Home.screenDescription)
    private let popularMoviesLabel = MVTitleLabel(
        textAlignment: .left,
        fontSize: 20,
        textColor: .white)
    private let searchTextField = MVTextField(placeHolder: K.Home.searchPlaceHolder)
    private let searchFilterButton = MVButton(image: K.Home.searchFilterButton)
    private var moviesCollectionView: UICollectionView! = nil
    private var moviesDataSource: UICollectionViewDiffableDataSource<HomeSection, AnyHashable>! = nil
    
    // MARK: - Properties
    var homePresenter: HomePresenter!

    private var popularMovies: [PopularMoviesPresentation]   = []
    private var topRatedMovies: [TopRatedMoviesPresentation] = []
    private var genres: [GenresPresentation]                 = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        homePresenter.loadCurrentUser()
        homePresenter.loadHomeServicesWithTaskGroup()
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
    }
    
    private func configureViewController() {
        view.backgroundColor = K.Styles.backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureUserPicture() {
        view.addSubview(userPicture)
        userPicture.configureConstraints(
            top: (view.safeAreaLayoutGuide.topAnchor, 16),
            leading: (view.leadingAnchor, 24))
        userPicture.configureHeight(height: 50)
        userPicture.configureWidth(width: 50)
    }
    
    private func configureUserUsername() {
        view.addSubview(userFullname)
        userFullname.configureConstraints(
            top: (userPicture.topAnchor, 4),
            leading: (userPicture.trailingAnchor, 16),
            trailing: (view.trailingAnchor, -16))
        userFullname.configureHeight(height: 20)
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
        searchTextField.backgroundColor = K.Styles.childViewsColor
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
            collectionViewLayout: GenerateLayout.generateLayout())
        view.addSubview(collectionView)
        
        collectionView.autoresizingMask             = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor              = K.Styles.backgroundColor
        collectionView.delegate                     = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            PopularCell.self,
            forCellWithReuseIdentifier: PopularCell.cellID)
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.cellID)
        collectionView.register(
            TopRatedCell.self,
            forCellWithReuseIdentifier: TopRatedCell.cellID)
        collectionView.register(
            MVHeaderView.self,
            forSupplementaryViewOfKind: K.Home.sectionHeader,
            withReuseIdentifier: MVHeaderView.identifier)
        
        collectionView.configureConstraints(
            top: (searchTextField.bottomAnchor, 0),
            leading: (view.leadingAnchor, 24),
            trailing: (view.trailingAnchor, -24),
            bottom: (view.bottomAnchor, 0))
        
        moviesCollectionView = collectionView
    }
    
    private func configureDataSource() {
        moviesDataSource = UICollectionViewDiffableDataSource<
            HomeSection,
            AnyHashable>(collectionView: moviesCollectionView) { (collectionView: UICollectionView,
                                                                  indexPath: IndexPath,
                                                                  item: AnyHashable) -> UICollectionViewCell? in
            let sectionType = HomeSection.allCases[indexPath.section]
        
            switch sectionType {
            case .popular:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.cellID,
                                                              for: indexPath) as! PopularCell
                let popularMovie = self.popularMovies[indexPath.row]
                cell.set(with: popularMovie)
                return cell
            case .category:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.cellID,
                                                              for: indexPath) as! CategoryCell
                let genre = self.genres[indexPath.row]
                cell.set(with: genre)
                return cell
            case .topRated:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.cellID,
                                                              for: indexPath) as! TopRatedCell
                let topRatedMovie = self.topRatedMovies[indexPath.row]
                cell.set(with: topRatedMovie)
                return cell
            }
        }
        
        moviesDataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                        kind: String,
                                                        indexPath: IndexPath) -> UICollectionReusableView? in
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MVHeaderView.identifier,
                for: indexPath) as? MVHeaderView else { fatalError() }
            supplementaryView.label.text = HomeSection.allCases[indexPath.section].rawValue
            
            return supplementaryView
        }
        let snapshot = snapshotCurrentState()
        moviesDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotCurrentState() -> NSDiffableDataSourceSnapshot<HomeSection, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>()
        snapshot.appendSections([HomeSection.popular])
        snapshot.appendItems(popularMovies)
   
        snapshot.appendSections([HomeSection.category])
        snapshot.appendItems(genres)
        
        snapshot.appendSections([HomeSection.topRated])
        snapshot.appendItems(topRatedMovies)
        
        return snapshot
    }
}

// MARK: - Button Tapped
extension HomeViewController {
    @objc
    private func searchFilterButtonTapped() {}
}

// MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {}

// MARK: - Home Presenter Output
extension HomeViewController: HomePresenterOutput {
    
    func showCurrentUser(user: UserPresentation) {
        userPicture.setImage(with: user.profilePic ?? "")
        userFullname.text = "Hello, \(user.fullName ?? "Anonymous")"
    }
    
    func showPopularMovies(movies popularMovies: [PopularMoviesPresentation]) {
        self.popularMovies.append(contentsOf: popularMovies)
        configureDataSource()
    }
    
    func showGenres(genres: [GenresPresentation]) {
        self.genres.append(contentsOf: genres)
        configureDataSource()
    }
    
    func showTopRatedMovies(movies topRatedMovies: [TopRatedMoviesPresentation]) {
        self.topRatedMovies.append(contentsOf: topRatedMovies)
        configureDataSource()
    }
}
