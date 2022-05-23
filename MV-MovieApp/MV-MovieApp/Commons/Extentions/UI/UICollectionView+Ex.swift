//
//  UICollectionView+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 23.05.2022.
//

import UIKit

extension UICollectionView {
    
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.className,
                 forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func register(cellType: UICollectionReusableView.Type,
                  sectionHeader: String) {
        register(cellType.className,
                 forSupplementaryViewOfKind: sectionHeader,
                 withReuseIdentifier: cellType.identifier)
    }
    
    func dequeView<T: UICollectionViewCell>(cellType: T.Type,
                                            indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: cellType.identifier,
            for: indexPath) as? T else { fatalError() }
        return cell
    }
    
    func dequeView<T: UICollectionReusableView>(cellType: T.Type,
                                                kind: String,
                                                indexPath: IndexPath) -> T {
        guard let supplementaryView = self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: cellType.identifier,
            for: indexPath) as? T else { fatalError() }
        return supplementaryView
    }
}
