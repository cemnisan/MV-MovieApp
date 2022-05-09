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
    
        loadingIndicatorView.configureConstraints(centerX: (view.centerXAnchor, 0),
                                                  centerY: (view.centerYAnchor, 0))
        loadingIndicatorView.configureWidth(width: 170)
        loadingIndicatorView.configureHeight(height: 170)
  
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
