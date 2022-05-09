//
//  BaseViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 8.05.2022.
//

import UIKit
import MV_Components

class BaseViewController: UIViewController {
    
    private var loadingIndicatorView: MVLoadingIndicator!

    func showLoadingView() {
        loadingIndicatorView = MVLoadingIndicator(backgroundColor: K.Styles.backgroundColor)
        view.addSubview(loadingIndicatorView)
        
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicatorView.widthAnchor.constraint(equalToConstant: 170),
            loadingIndicatorView.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        loadingIndicatorView.startIndicatorView()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.loadingIndicatorView.stopIndicatorView()
            self.loadingIndicatorView.removeFromSuperview()
            self.loadingIndicatorView = nil
        }
    }
}
