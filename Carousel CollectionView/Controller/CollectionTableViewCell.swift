//
//  CollectionTableViewCell.swift
//  Carousel CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/17.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCollectionDidTapItem(with viewModel: TileCollectionViewCellModel)
}

class CollectionTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionTableViewCell"
    private var viewModels: [TileCollectionViewCellModel] = []
    weak var delegate: CollectionTableViewCellDelegate?

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
//            self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
            self.collectionView.register(TileCollectionViewCell.nib(), forCellWithReuseIdentifier: TileCollectionViewCell.identifier)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: CollectionTableViewCellModel) {
        self.viewModels = viewModel.viewModels
        collectionView.reloadData()
    }
    
    static func nib() -> UINib {
        UINib(nibName: CollectionTableViewCell.identifier, bundle: nil)
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TileCollectionViewCell.identifier, for: indexPath) as? TileCollectionViewCell else { fatalError("error") }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate {
}

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width / 2.5
        return CGSize(width: width, height: width / 1.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        
        delegate?.collectionTableViewCollectionDidTapItem(with: viewModel)
    }
}
