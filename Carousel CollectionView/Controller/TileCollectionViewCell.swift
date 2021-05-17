//
//  TileCollectionViewCell.swift
//  Carousel CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/17.
//

import UIKit

class TileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TileCollectionViewCell"

    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backgroundColor = .blue
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
    func configure(with viewModel: TileCollectionViewCellModel) {
        contentView.backgroundColor = viewModel.backgrounColor
        nameLabel.text = viewModel.name
    }
    
    static func nib() -> UINib {
        UINib(nibName: TileCollectionViewCell.identifier, bundle: nil)
    }
}
