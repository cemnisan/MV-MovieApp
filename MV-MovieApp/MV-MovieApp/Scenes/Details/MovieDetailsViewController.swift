//
//  MovieDetailsViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 20.05.2022.
//

import UIKit
import MV_Components

final class MovieDetailViewController: UIViewController {
    
    private let topBannerView = UIView()
    private let movieBackgroundImage = UIImageView()
    private let moviePosterImage = UIImageView()
    private let watchNowButton = MVButton(
        backgroundColor: .systemRed,
        title: "Watch Now",
        cornerRadius: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension MovieDetailViewController {
    
    private func configure() {
        configureViewController()
    }
    
    private func configureViewController() {
        view.backgroundColor = K.Styles.backgroundColor
    }
    
    private func configureMovieBackgroundImage() {
        
    }
}
