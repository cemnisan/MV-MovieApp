//
//  UINavigationController+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 8.05.2022.
//

import UIKit

extension UINavigationController  {
    
    func configureModal() {
        self.modalTransitionStyle   = .crossDissolve
        self.modalPresentationStyle = .fullScreen
    }
}
