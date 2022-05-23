//
//  UICollectionReusableView+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 23.05.2022.
//

import UIKit

extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var className: UICollectionReusableView.Type {
        return self
    }
}
