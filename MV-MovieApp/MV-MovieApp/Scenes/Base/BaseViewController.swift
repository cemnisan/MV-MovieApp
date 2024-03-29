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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = K.Styles.backgroundColor
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            self.loadingIndicatorView = MVLoadingIndicator(backgroundColor: K.Styles.backgroundColor)
            self.view.addSubview(self.loadingIndicatorView)
            self.loadingIndicatorView.configureConstraints(
                centerX: (self.view.centerXAnchor, 0),
                centerY: (self.view.centerYAnchor, 0))
            self.loadingIndicatorView.configureWidth(width: 170)
            self.loadingIndicatorView.configureHeight(height: 170)
            self.loadingIndicatorView.startIndicatorView()
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.loadingIndicatorView.stopIndicatorView()
            self.loadingIndicatorView.removeFromSuperview()
            self.loadingIndicatorView = nil
        }
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}
