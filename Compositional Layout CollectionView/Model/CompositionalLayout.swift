//
//  CompositionalLayout.swift
//  Compositional Layout CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/18.
//

import UIKit

enum CompositionalLayout {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                // absolute 는 고정값, estimated 는 추측, fraction 은 퍼센트
                widthDimension: .fractionalWidth(2 / 3),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        // 아이템 간의 간격 설정
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0.5, bottom: 1, trailing: 0.5)
       
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0.5, bottom: 1, trailing: 0.5)

        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 3),
                heightDimension: .fractionalHeight(1)
            ),
            subitem: verticalStackItem,
            count: 2
        )
        
        // Group
        
        let group1 = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1 / 4)
            ),
            subitem: verticalStackGroup,
            count: 3
        )
    
        let group2 = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1 / 4)
            ),
            subitems: [item, verticalStackGroup]
        )
        
        // Item
        let item3 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                // absolute 는 고정값, estimated 는 추측, fraction 은 퍼센트
                widthDimension: .fractionalWidth(1 / 3),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item3.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0.5, bottom: 1, trailing: 0.5)
        
        // Group
        
        let group3 = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1 / 4)
            ),
            subitems: [verticalStackGroup, verticalStackGroup, item3]
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2)
            ),
            subitems: [group3, group1, group2, group1]
        )
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        // Return
        return UICollectionViewCompositionalLayout(section: section)
    }
}
