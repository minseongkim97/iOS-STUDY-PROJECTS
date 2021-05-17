//
//  MyCollectionViewCell.swift
//  Compositional Layout CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/17.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCollectionViewCell"

    @IBOutlet private weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // 셀의 재사용 문제를 방지
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with urlString: String) {
        guard  let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        }
        task.resume()
    }
    
    static func nib() -> UINib {
        UINib(nibName: MyCollectionViewCell.identifier, bundle: nil)
    }
}
