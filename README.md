# iOS-study-projects
## Diffable DataSource
<코드 참조> [ZeddiOS 블로그](https://zeddios.tistory.com/1197)

### 알게 된 것

- UUID
- Diffable DataSource

<br>

> UUID
- 같은 'name'이 포함되어 있는 경우 식별해주기 위한 장치

```swift
class DJ: Hashable {

    let id = UUID()
    let name: String

    init(name: String) {
        self.name = name
    }

    static func == (lhs: ViewController.DJ, rhs: ViewController.DJ) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
```

<br>

> Diffable DataSource
- UICollectionViewDataSource : 'reloadData'를 사용함으로 애니메이션 효과가 없음 -> 사용자 경험 저하
- Diffable DataSource : snapShot(current state of the data)이라는 개념을 도입해 Section과 Item에 대해 indexPath가 아닌 유니크한 identifier(UUID)로 업데이트 & 애니메이션 효과

<br>

- Item, Section : Hashable 준수
<img width="1000" height="300" src="https://user-images.githubusercontent.com/68727819/119234457-fc5edb80-bb68-11eb-8a3a-76b111a204f2.png"/>

<br>

- dataSource와 snapShot을 사용
```swift
var dataSource: UICollectionViewDiffableDataSource<Section,DJ>!

func setupDataSource() {
     self.dataSource =
         UICollectionViewDiffableDataSource<Section, DJ>(collectionView: self.collectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DJCollectionViewCell else { preconditionFailure() }
         
         cell.configure(text: dj.name)
         
         return cell
     }
}
```
```swift
func performQuery(with filter: String?) {
    let filtered = self.arr.filter { $0.name.lowercased().hasPrefix(filter ?? "") }

    var snapshot = NSDiffableDataSourceSnapshot<Section, DJ>()
    snapshot.appendSections([.main])
    snapshot.appendItems(filtered)
    self.dataSource.apply(snapshot, animatingDifferences: true)
}
```

<br>

- 실행

<img width="300" height="600" src="https://user-images.githubusercontent.com/68727819/119234262-ebfa3100-bb67-11eb-8103-4c1c9d8581f2.gif"/>

