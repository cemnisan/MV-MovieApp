//
//  HomeViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var homePresenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await homePresenter.loadPopularMovies()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func handleOutput(_ output: HomePresenterOutput) {
        switch output {
        case .updateTitle(_):
            print("")
        case .setLoading(_):
            print("")
        case .showPopularMovies(let popularMovie):
            print(popularMovie)
        case .showTopRatedMovies(_):
            print("")
        }
    }
}
