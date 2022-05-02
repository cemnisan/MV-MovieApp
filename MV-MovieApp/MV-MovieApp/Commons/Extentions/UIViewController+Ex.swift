//
//  UIViewController+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit

extension UIViewController {
    
    func addSubviews(views: UIView...) {
        views.forEach { view.addSubview($0) }
    }
}
