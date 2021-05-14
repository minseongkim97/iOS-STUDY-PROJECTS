//
//  MyCollectionViewCell.swift
//  Start CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/15.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    static let identifier = "MyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // 셀의 재사용 문제를 방지
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        imageView.image = nil
//        backgroundColor = .systemBackground
    }
    
    func configure(with image: UIImage, text: String) {
        imageView.image = image
        label.text = text
        backgroundColor = .black
    }
    
    static func nib() -> UINib {
        UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
}
