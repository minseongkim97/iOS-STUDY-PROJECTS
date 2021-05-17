# iOS-study-projects
## Compositional Layout CollectionView

### 알게 된 것

- Compositional Layout
- Unsplash Search Photo API(Networking)
- Scroll할 때 UISearchBar 숨기기
- 검색 후 키보드 제거 
<br>

> Compositional Layout
```swift
    func createLayout() -> UICollectionViewCompositionalLayout {
   
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
        
       
        let item3 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                // absolute 는 고정값, estimated 는 추측, fraction 은 퍼센트
                widthDimension: .fractionalWidth(1 / 3),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item3.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0.5, bottom: 1, trailing: 0.5)
        
     
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

```
<img width="300" height="600" src="https://user-images.githubusercontent.com/68727819/118542243-b7fcc580-b78d-11eb-8918-cc9c6284fab2.gif"/> <img width="300" height="600" src="https://user-images.githubusercontent.com/68727819/118542628-3a858500-b78e-11eb-8491-eaeedfb2f7e5.png"/>

<br>

> Unsplash Search Photo API(Networking)
- URLSession
```swift
struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
}
```
```swift
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
```


<br>

> Scroll할 때 UISearchBar 숨기기
```swift
// 스크롤시 searchbar 숨기기
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // 스크롤 아래인지 위인지 알아내는 포지션
    let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)

    if actualPosition.y < 0 {
        searchBar.isHidden = true
    } else {
        searchBar.isHidden = false
    }
}
```

<br>

> 검색 후 키보드 제거
```swift
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
```

<img width="300" height="600" src="https://user-images.githubusercontent.com/68727819/118544092-1f1b7980-b790-11eb-89a7-3785fbfb9ab7.gif"/>



