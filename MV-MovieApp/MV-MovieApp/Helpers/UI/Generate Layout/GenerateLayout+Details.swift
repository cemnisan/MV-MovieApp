//
//  GenerateLayout+Details.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import UIKit

// MARK: - Detail Layouts
extension GenerateLayout {
    
    static func generateDetailLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int,
             layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let isWideView = layoutEnvironment
                .container
                .effectiveContentSize.width > 500
            let sectionLayoutKind = DetailsSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .cast: return generateCastLayout()
            case .relatedMovies: return generateRelatedMoviesLayout(isWide: isWideView)
            }
        }
        return layout
    }
    
    fileprivate static func generateCastLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(90),
            heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 5,
            bottom: 5,
            trailing: 0)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: K.Home.sectionHeader,
            alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    fileprivate static func generateRelatedMoviesLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.9/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth  = 0.650
        let groupFractionalHeight: CGFloat = isWide ? 1.1/3 : 1.1/3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 5,
            trailing: 20)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: K.Home.sectionHeader,
            alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
