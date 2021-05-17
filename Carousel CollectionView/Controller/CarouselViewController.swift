//
//  ViewController.swift
//  Carousel CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/16.
//

import UIKit

class CarouselViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CarouselViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else { fatalError("error") }
        
        cell.configure(with: viewModels[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension CarouselViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.size.width / 2
    }
}

extension CarouselViewController: CollectionTableViewCellDelegate {
    func collectionTableViewCollectionDidTapItem(with viewModel: TileCollectionViewCellModel) {
        let alert = UIAlertController(title: viewModel.name,
                                      message: "You successfully got the selected item",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}
