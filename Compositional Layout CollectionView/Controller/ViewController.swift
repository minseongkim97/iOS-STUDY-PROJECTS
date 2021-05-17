//
//  ViewController.swift
//  Compositional Layout CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
            // 테두리 없애기
            self.searchBar.backgroundImage = UIImage()
        }
    }
    
//    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.collectionViewLayout = CompositionalLayout.createLayout()
            self.collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        }
    }
    
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchPhotos(query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id={myid}"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as? MyCollectionViewCell else { fatalError("error") }
        
        cell.configure(with: imageURLString)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // 스크롤시 searchbar 숨기기
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 아래인지 위인지 알아내는 포지션
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)

        if actualPosition.y < 0 {
            searchBar.isHidden = true
//            UIView.animate(withDuration: 0.5) {
//                self.view.layoutIfNeeded()
//            }
        } else {
            searchBar.isHidden = false
//            UIView.animate(withDuration: 0.5) {
//                self.view.layoutIfNeeded()
//            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색후 키보드 제거
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = [] // 없어도 됨
            collectionView.reloadData()
            fetchPhotos(query: text)
        }
    }
}
