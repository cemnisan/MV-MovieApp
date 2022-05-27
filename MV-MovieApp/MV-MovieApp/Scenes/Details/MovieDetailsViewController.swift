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
    
    private let backButton  = MVButton(image: UIImage(systemName: "chevron.backward")!)
    private let contentView = UIView()
    private let scrollView  = UIScrollView()
    private let movieBackgroundImage = UIImageView()
    private let moviePosterImage     = UIImageView()
    private let movieNameLabel = MVTitleLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white)
    let containerStackView            = UIStackView()
    private let imdbContainerView     = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    private let genreContainerView    = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    private let releasedContainerView = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    private let saveButton            = MVButton(frame: .zero)
    private let shareButton           = MVButton(frame: .zero)
    private let actionGenreLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 15,
        textColor: .white, text: "Action")
    private let imdbLogoView = MVLogoImage(
        image: K.Home.rateLogo,
        tintColor: .systemOrange)
    private let imdbRateLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 15,
        textColor: .white,
        text: nil)
    private let releaseDateLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 15,
        textColor: .white,
        text: "2017")
    private let synopsisLabel = MVTitleLabel(
        textAlignment: .left,
        fontSize: 22,
        textColor: .white)
    private let synopsisContent = MVBodyLabel(frame: .zero)
    private let castLabel       = MVTitleLabel(
        textAlignment: .left,
        fontSize: 22,
        textColor: .white)
    
    private var detailsCollectionView: UICollectionView!   = nil
    private var detailsDataSource: DataSource!             = nil
    
    private var similarMovies: [SimilarMoviesPresentation] = []
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
        configureSaveButton()
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
        moviePosterImage.translatesAutoresizingMaskIntoConstraints = false
        moviePosterImage.layer.cornerRadius = 10
        moviePosterImage.clipsToBounds      = true
        moviePosterImage.contentMode        = .scaleToFill
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
        containerStackView.axis         = .horizontal
        containerStackView.distribution = .equalSpacing
        containerStackView.spacing      = 16
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerStackView)
        containerStackView.configureConstraints(
            top: (moviePosterImage.bottomAnchor, 16),
            leading: (view.leadingAnchor, 16))
        containerStackView.configureHeight(height: 30)
    }
    
    private func configureSaveButton() {
        let buttonsStackView = UIStackView()
        saveButton.setBackgroundImage(
            UIImage(systemName: "bookmark"),
            for: .normal)
        shareButton.setBackgroundImage(
            UIImage(systemName: "square.and.arrow.up.on.square"),
            for: .normal)
        [saveButton,
         shareButton
        ].forEach {
            $0.configureWidth(width: 27)
            $0.tintColor = .white
            buttonsStackView.addArrangedSubview($0)
        }
        buttonsStackView.axis         = .horizontal
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.spacing      = 16
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
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
        let stackView          = UIStackView(arrangedSubviews: [imdbLogoView, imdbRateLabel])
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing      = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imdbContainerView.addSubview(stackView)
        
        stackView.configureConstraints(
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
        synopsisLabel.text = "Synopsis"
        synopsisLabel.configureConstraints(
            top: (containerStackView.bottomAnchor, 24),
            leading: (contentView.leadingAnchor, 16),
            trailing: (contentView.trailingAnchor, -16))
        synopsisLabel.configureHeight(height: 20)
    }
    
    private func configureSynopsisContent() {
        contentView.addSubviews(views: synopsisContent)
        synopsisContent.numberOfLines = 6
        synopsisContent.textColor     = #colorLiteral(red: 0.784393847, green: 0.7843937278, blue: 0.7843937278, alpha: 1)
        synopsisContent.configureConstraints(
            top: (synopsisLabel.bottomAnchor, 8),
            leading: (contentView.leadingAnchor, 16),
            trailing: (contentView.trailingAnchor, -16))
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: GenerateLayout.generateDetailLayout())
        contentView.addSubviews(views: collectionView)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor  = K.Styles.backgroundColor
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellType: CastCell.self)
        collectionView.register(cellType: PopularCell.self)
        collectionView.register(
            cellType: MVHeaderView.self,
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
                let cell = collectionView.dequeView(
                    cellType: CastCell.self,
                    indexPath: indexPath)
                let cast = self.movieCast[indexPath.row]
                cell.set(with: cast)
                return cell
            case .relatedMovies:
                let cell = collectionView.dequeView(
                    cellType: PopularCell.self,
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailsPresenter.userDidSelectItem(at: indexPath)
    }
}

extension MovieDetailViewController: MovieDetailPresenterOutput {
    
    func showMovieDetail(movie: MovieDetailPresentation) {
        title                = movie.movieTitle
        movieNameLabel.text  = movie.movieTitle
        synopsisContent.text = movie.movieOverview
        imdbRateLabel.text   = String(movie.movieVoteAverage)
        movieBackgroundImage.setImage(with: "https://image.tmdb.org/t/p/original\(movie.movieBackgroundPath ?? "")")
        moviePosterImage.setImage(with: "\(K.API.w500Image)\(movie.moviePosterPath ?? "")")
    }
    
    func showCast(cast: [MovieCastPresentation]) {
        movieCast.append(contentsOf: cast)
        configureDataSource()
    }
    
    func showRelatedMovies(movies: [SimilarMoviesPresentation]) {
        similarMovies.append(contentsOf: movies)
        configureDataSource()
    }
}
