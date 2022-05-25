//
//  HomeViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit
import MV_Components

typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, AnyHashable>
typealias Snapshot   = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>

final class HomeViewController: BaseViewController {
    
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
    private var moviesDataSource: DataSource! = nil
    
    // MARK: - Properties
    var homePresenter: HomePresenter!
    
    private var popularMovies: [PopularMoviesPresentation]   = []
    private var topRatedMovies: [TopRatedMoviesPresentation] = []
    private var genres: [GenresPresentation]                 = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        homePresenter.loadHomeServicesWithTaskGroup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homePresenter.loadCurrentUser()
    }
}

// MARK: - Configure
extension HomeViewController {
    
    private func configure() {
        configureViewController()
        createDismissKeyboardTapGesture()
        configureUserPicture()
        configureUserUsername()
        configureHomeDescription()
        configureSearchTextField()
        configureSearchFilterButton()
        configureMoviesCollectionView()
    }
    
    private func configureViewController() {
        title = K.Home.navTitle
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
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didSelectItem))
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: GenerateLayout.generateHomeLayout())
        view.addSubview(collectionView)
        
        collectionView.autoresizingMask             = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor              = K.Styles.backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled     = true
        collectionView.addGestureRecognizer(tapGestureRecognizer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(cellType: PopularCell.self)
        collectionView.register(cellType: CategoryCell.self)
        collectionView.register(cellType: TopRatedCell.self)
        collectionView.register(
            cellType: MVHeaderView.self,
            sectionHeader: K.Home.sectionHeader)
        collectionView.configureConstraints(
            top: (searchTextField.bottomAnchor, 0),
            leading: (view.leadingAnchor, 24),
            trailing: (view.trailingAnchor, -24),
            bottom: (view.bottomAnchor, 0))
        moviesCollectionView = collectionView
    }
    
    private func configureDataSource() {
        moviesDataSource = DataSource(collectionView: moviesCollectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             item: AnyHashable) -> UICollectionViewCell? in
            let sectionType = HomeSection.allCases[indexPath.section]
            
            switch sectionType {
            case .popular:
                let cell = collectionView.dequeView(cellType: PopularCell.self,
                                                    indexPath: indexPath)
                let popularMovie = self.popularMovies[indexPath.row]
                cell.set(with: popularMovie)
                return cell
            case .category:
                let cell = collectionView.dequeView(cellType: CategoryCell.self,
                                                    indexPath: indexPath)
                let genre = self.genres[indexPath.row]
                cell.set(with: genre)
                return cell
            case .topRated:
                let cell = collectionView.dequeView(cellType: TopRatedCell.self,
                                                    indexPath: indexPath)
                let topRatedMovie = self.topRatedMovies[indexPath.row]
                cell.set(with: topRatedMovie)
                return cell
            }
        }
        
        moviesDataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView,
             kind: String,
             indexPath: IndexPath) -> UICollectionReusableView? in
            let supplementaryView = collectionView.dequeView(
                cellType: MVHeaderView.self,
                kind: kind,
                indexPath: indexPath)
            supplementaryView.label.text = HomeSection.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        let snapshot = snapshotCurrentState()
        moviesDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotCurrentState() -> Snapshot {
        var snapshot = Snapshot()
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
    
    @objc
    private func didSelectItem(_ sender: UITapGestureRecognizer) {
        if let _ = moviesCollectionView?.indexPathForItem(at: sender.location(in: self.moviesCollectionView)) {
            homePresenter.userDidSelectMovie()
        }
    }
}

// MARK: - Home Presenter Output
extension HomeViewController: HomePresenterOutput {
    
    func showCurrentUser(user: UserPresentation) {
        userPicture.setImage(with: user.profilePic)
        userFullname.text = String(format: K.Home.welcomeLabel, user.fullName)
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
