//
//  HomeViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit
import MV_Components

final class HomeViewController: BaseViewController {

    private typealias DataSource   = UICollectionViewDiffableDataSource<HomeSection, AnyHashable>
    private typealias Snapshot     = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>
    
    private let userPicture        = MVImageView(cornerRadius: 25)
    private let userFullname       = MVTitleLabel(textAlignment: .left,
                                                  fontSize: 18,
                                                  textColor: .white)
    private let homeDescription    = MVSecondaryLabel(textAlignment: .left,
                                                      fontSize: 16,
                                                      textColor: K.Styles.globalColor,
                                                      text: K.Home.screenDescription)
    private let searchTextField    = MVTextField(placeHolder: K.Home.searchPlaceHolder)
    private let searchFilterButton = MVButton(image: K.Home.searchFilterButton)
    
    private var moviesCollectionView: UICollectionView! = nil
    private var moviesDataSource: DataSource!           = nil

    var homePresenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        homePresenter.viewDidLoad()
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
        searchTextField.backgroundColor    = K.Styles.childViewsColor
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
        
        collectionView.register(cellType: MovieCell.self)
        collectionView.register(cellType: CategoryCell.self)
        collectionView.register(cellType: TopRatedCell.self)
        collectionView.register(cellType: MVHeaderView.self,
                                sectionHeader: K.Home.sectionHeader)
        collectionView.configureConstraints(
            top: (searchTextField.bottomAnchor, 8),
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
                let cell = collectionView.dequeView(cellType: MovieCell.self,
                                                    indexPath: indexPath)
                if let popularMovie = item as? MoviePresentation { cell.set(with: popularMovie) }
                return cell
            case .category:
                let cell = collectionView.dequeView(cellType: CategoryCell.self,
                                                    indexPath: indexPath)
                if let genre = item as? GenrePresentation { cell.set(with: genre) }
                return cell
            case .topRated:
                let cell = collectionView.dequeView(cellType: TopRatedCell.self,
                                                    indexPath: indexPath)
                if let topRatedMovie = item as? MoviePresentation { cell.set(with: topRatedMovie) }
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
        snapshot.appendItems(homePresenter.homeViewModelCell.popularMovies ?? [])
        
        snapshot.appendSections([HomeSection.category])
        snapshot.appendItems(homePresenter.homeViewModelCell.categoryOfMovies ?? [])
        
        snapshot.appendSections([HomeSection.topRated])
        snapshot.appendItems(homePresenter.homeViewModelCell.topRatedMovies ?? [])
        
        return snapshot
    }
}

// MARK: - Button Tapped
extension HomeViewController {
    
    @objc
    private func searchFilterButtonTapped() {}
    
    @objc
    private func didSelectItem(_ sender: UITapGestureRecognizer) {
        if let indexPath = moviesCollectionView?
            .indexPathForItem(at: sender.location(in: self.moviesCollectionView)) {
            homePresenter.userDidSelectItem(with: indexPath)
        }
    }
}

// MARK: - Home Presenter Output
extension HomeViewController: HomePresenterOutput {
    
    func showCurrentUser(user: UserPresentation) {
        userPicture.setImage(with: user.profilePic)
        userFullname.text = String(format: K.Home.welcomeLabel, user.fullName)
    }
    
    func showPopularMovies() {
        configureDataSource()
    }
    
    func showGenres() {
        configureDataSource()
    }
    
    func showTopRatedMovies() {
        configureDataSource()
    }
}
