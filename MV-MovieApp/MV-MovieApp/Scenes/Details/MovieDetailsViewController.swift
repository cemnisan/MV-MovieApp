//
//  MovieDetailsViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 20.05.2022.
//

import UIKit
import MV_Components

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<DetailsSection, AnyHashable>
fileprivate typealias Snapshot   = NSDiffableDataSourceSnapshot<DetailsSection, AnyHashable>

final class MovieDetailViewController: UIViewController {
    
    private let contentView           = UIView()
    private let scrollView            = UIScrollView()
    
    private let movieBackgroundImage  = UIImageView()
    private let moviePosterImage      = MVImageView(cornerRadius: 10)
    private let movieNameLabel        = MVTitleLabel(textAlignment: .left,
                                                     fontSize: 17,
                                                     textColor: .white)
    private let containerStackView    = MVStackView(spacing: 16)
    private let imdbContainerView     = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    private let genreContainerView    = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    private let releasedContainerView = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    
    private let buttonsStackView      = MVStackView(spacing: 16)
    private let saveButton            = MVButton(frame: .zero)
    private let shareButton           = MVButton(frame: .zero)
    
    private let actionGenreLabel      = MVSecondaryLabel(textAlignment: .center,
                                                         fontSize: 15,
                                                         textColor: .white,
                                                         text: K.Details.genreLabel)
    private let imdbStackViews        = MVStackView(spacing: 6)
    private let imdbLogoView          = MVLogoImage(image: K.Home.rateLogo,
                                                    tintColor: .systemOrange)
    private let imdbRateLabel         = MVSecondaryLabel(textAlignment: .left,
                                                         fontSize: 15,
                                                         textColor: .white,
                                                         text: nil)
    private let releaseDateLabel      = MVSecondaryLabel(textAlignment: .center,
                                                         fontSize: 15,
                                                         textColor: .white,
                                                         text: K.Details.dateLabel)
    private let synopsisLabel         = MVTitleLabel(textAlignment: .left,
                                                     fontSize: 22,
                                                     textColor: .white)
    private let synopsisContent       = MVBodyLabel(frame: .zero)
    
    private var detailsCollectionView: UICollectionView!   = nil
    private var detailsDataSource: DataSource!             = nil
    
    private var similarMovies: [MoviePresentation] = []
    private var movieCast: [MovieCastPresentation]         = []
    
    var detailsPresenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        detailsPresenter.loadMovieServiceWithTaskgroup()
    }
}

extension MovieDetailViewController {
    
    private func configure() {
        configureViewController()
        configureScrollView()
        configureBackgroundImage()
        configurePosterImage()
        configureMovieNameLabel()
        configureContainerViews()
        configureButtonsStackView()
        configureGenreLabel()
        configureImdbElements()
        configureReleaseDateLabel()
        configureSynopsisLabel()
        configureSynopsisContent()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureViewController() {
        view.backgroundColor = K.Styles.backgroundColor
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        contentView.configureWidth(anchor: scrollView.widthAnchor)
        contentView.configureHeight(height: 970)
    }
    
    private func configureBackgroundImage() {
        contentView.addSubview(movieBackgroundImage)
        movieBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        movieBackgroundImage.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0))
        movieBackgroundImage.configureHeight(height: 300)
    }
    
    private func configurePosterImage() {
        contentView.addSubview(moviePosterImage)
        moviePosterImage.configureConstraints(
            leading: (contentView.leadingAnchor, 8),
            bottom: (movieBackgroundImage.bottomAnchor, 88))
        moviePosterImage.configureWidth(width: 138)
        moviePosterImage.configureHeight(height: 175)
    }
    
    private func configureMovieNameLabel() {
        contentView.addSubview(movieNameLabel)
        movieNameLabel.numberOfLines = 3
        movieNameLabel.configureConstraints(
            top: (movieBackgroundImage.bottomAnchor, 16),
            leading: (moviePosterImage.trailingAnchor, 8),
            trailing: (contentView.trailingAnchor, -8))
    }
    
    private func configureContainerViews() {
        [imdbContainerView,
         genreContainerView,
         releasedContainerView
        ].forEach {
            $0.configureWidth(width: 75)
            $0.configureHeight(height: 30)
            containerStackView.addArrangedSubview($0)
        }
        contentView.addSubview(containerStackView)
        containerStackView.configureConstraints(
            top: (moviePosterImage.bottomAnchor, 16),
            leading: (view.leadingAnchor, 16))
        containerStackView.configureHeight(height: 30)
    }
    
    private func configureButtons() {
        saveButton.setBackgroundImage(K.Details.saveButton,
                                      for: .normal)
        shareButton.setBackgroundImage(K.Details.shareButton,
                                       for: .normal)
    }
    
    private func configureButtonsStackView() {
        configureButtons()
        [saveButton,
         shareButton
        ].forEach {
            $0.configureWidth(width: 27)
            $0.tintColor = .white
            buttonsStackView.addArrangedSubview($0)
        }
        contentView.addSubview(buttonsStackView)
        buttonsStackView.configureConstraints(
            top: (moviePosterImage.bottomAnchor, 16),
            trailing: (contentView.trailingAnchor, -16))
        buttonsStackView.configureHeight(height: 27)
    }
    
    private func configureGenreLabel() {
        genreContainerView.addSubview(actionGenreLabel)
        actionGenreLabel.configureConstraints(
            centerX: (genreContainerView.centerXAnchor, 0),
            centerY: (genreContainerView.centerYAnchor, 0))
    }
    
    private func configureImdbElements() {
        [imdbLogoView,
         imdbRateLabel
        ].forEach { imdbStackViews.addArrangedSubview($0) }
        imdbContainerView.addSubview(imdbStackViews)
        imdbStackViews.configureConstraints(
            centerX: (imdbContainerView.centerXAnchor, 0),
            centerY: (imdbContainerView.centerYAnchor, 0))
    }
    
    private func configureReleaseDateLabel() {
        releasedContainerView.addSubview(releaseDateLabel)
        releaseDateLabel.configureConstraints(
            centerX: (releasedContainerView.centerXAnchor, 0),
            centerY: (releasedContainerView.centerYAnchor, 0))
    }
    
    private func configureSynopsisLabel() {
        contentView.addSubview(synopsisLabel)
        synopsisLabel.text = K.Details.synopsisLabel
        synopsisLabel.configureConstraints(
            top: (containerStackView.bottomAnchor, 24),
            leading: (contentView.leadingAnchor, 16),
            trailing: (contentView.trailingAnchor, -16))
        synopsisLabel.configureHeight(height: 20)
    }
    
    private func configureSynopsisContent() {
        contentView.addSubviews(views: synopsisContent)
        synopsisContent.numberOfLines = 5
        synopsisContent.textColor     = K.Styles.globalColor
        synopsisContent.configureConstraints(
            top: (synopsisLabel.bottomAnchor, 8),
            leading: (contentView.leadingAnchor, 16),
            trailing: (contentView.trailingAnchor, -16))
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: GenerateLayout.generateDetailLayout())
        contentView.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor  = K.Styles.backgroundColor
        collectionView.delegate         = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(cellType: CastCell.self)
        collectionView.register(cellType: MovieCell.self)
        collectionView.register(cellType: MVHeaderView.self,
                                sectionHeader: K.Home.sectionHeader)
        collectionView.configureConstraints(
            top: (synopsisContent.bottomAnchor, 0),
            leading: (contentView.leadingAnchor, 16),
            trailing: (contentView.trailingAnchor, -16),
            bottom: (view.safeAreaLayoutGuide.bottomAnchor, -8))
        detailsCollectionView = collectionView
    }
    
    private func configureDataSource() {
        detailsDataSource = DataSource(collectionView: detailsCollectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             item: AnyHashable) -> UICollectionViewCell? in
            let sectionType = DetailsSection.allCases[indexPath.section]
            
            switch sectionType {
            case .movieCast:
                let cell = collectionView.dequeView(cellType: CastCell.self,
                                                    indexPath: indexPath)
                let cast = self.movieCast[indexPath.row]
                cell.set(with: cast)
                return cell
            case .relatedMovies:
                let cell = collectionView.dequeView(cellType: MovieCell.self,
                                                    indexPath: indexPath)
                let similarMovie = self.similarMovies[indexPath.row]
                cell.set(with: similarMovie)
                return cell
            }
        }
        
        detailsDataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView,
             kind: String,
             indexPath: IndexPath) -> UICollectionReusableView? in
            let supplementaryView = collectionView.dequeView(
                cellType: MVHeaderView.self,
                kind: kind,
                indexPath: indexPath)
            supplementaryView.label.text = DetailsSection.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        let snapshot = snapshotCurrentState()
        detailsDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotCurrentState() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([DetailsSection.movieCast])
        snapshot.appendItems(movieCast)
        
        snapshot.appendSections([DetailsSection.relatedMovies])
        snapshot.appendItems(similarMovies)
        return snapshot
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        detailsPresenter.userDidSelectItem(at: indexPath)
    }
}

extension MovieDetailViewController: MovieDetailPresenterOutput {
    
    func showMovieDetail(movie: MovieDetailPresentation) {
        let backgroundImage  = "\(K.API.originalImage)\(movie.movieBackgroundPath ?? "")"
        let posterImage      = "\(K.API.w500Image)\(movie.moviePosterPath ?? "")"
        
        title                = movie.movieTitle
        movieNameLabel.text  = movie.movieTitle
        synopsisContent.text = movie.movieOverview
        imdbRateLabel.text   = String(movie.movieVoteAverage)
        
        movieBackgroundImage.setImage(with: backgroundImage)
        moviePosterImage.setImage(with: posterImage)
    }
    
    func showCast(cast: [MovieCastPresentation]) {
        movieCast.append(contentsOf: cast)
        configureDataSource()
    }
    
    func showRelatedMovies(movies: [MoviePresentation]) {
        similarMovies.append(contentsOf: movies)
        configureDataSource()
    }
}
