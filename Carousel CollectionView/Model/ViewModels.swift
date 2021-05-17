//
//  ViewModel.swift
//  Carousel CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/17.
//

import UIKit

let viewModels: [CollectionTableViewCellModel] = [
    CollectionTableViewCellModel(
        viewModels: [
            TileCollectionViewCellModel(name: "Apple", backgrounColor: .red),
            TileCollectionViewCellModel(name: "Google", backgrounColor: .yellow),
            TileCollectionViewCellModel(name: "NVidia", backgrounColor: .orange),
            TileCollectionViewCellModel(name: "Facebook", backgrounColor: .blue),
            TileCollectionViewCellModel(name: "MS", backgrounColor: .systemPink)
        ]
    ),
    CollectionTableViewCellModel(
        viewModels: [
            TileCollectionViewCellModel(name: "Apple", backgrounColor: .red),
            TileCollectionViewCellModel(name: "Google", backgrounColor: .yellow),
            TileCollectionViewCellModel(name: "NVidia", backgrounColor: .orange),
            TileCollectionViewCellModel(name: "Facebook", backgrounColor: .blue),
            TileCollectionViewCellModel(name: "MS", backgrounColor: .systemPink)
        ]
    )
]
