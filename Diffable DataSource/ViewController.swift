import UIKit

class ViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }
    
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
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }

    @IBOutlet private weak var collectionView: UICollectionView!
    var arr = [
        DJ(name: "KIM"), DJ(name: "Zedf"), DJ(name: "dslfkj"), DJ(name: "lkjdn"),
        DJ(name: "dlkn"), DJ(name: "KIM"), DJ(name: "akenf"), DJ(name: "qwnbv"),
        DJ(name: "engvb"), DJ(name: "ekmnv"), DJ(name: "ckje"), DJ(name: "e;ojk"),
        DJ(name: "ekjnve"), DJ(name: "ekfjd"), DJ(name: "elkjd"), DJ(name: "KIM"),
    ]
    var dataSource: UICollectionViewDiffableDataSource<Section,DJ>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.collectionView.collectionViewLayout = self.createLayout()
        self.setupDataSource()
        self.performQuery(with: nil)
        
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchResultsUpdater = self
        self.navigationItem.title = "Search DJ"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupDataSource() {
         self.collectionView.register(DJCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
         self.dataSource =
             UICollectionViewDiffableDataSource<Section, DJ>(collectionView: self.collectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
             guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DJCollectionViewCell else { preconditionFailure() }
                cell.configure(text: dj.name)
             return cell
         }
    }
    
    func performQuery(with filter: String?) {
        let filtered = self.arr.filter { $0.name.lowercased().hasPrefix(filter ?? "") }

        var snapshot = NSDiffableDataSourceSnapshot<Section, DJ>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filtered)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(32))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            return section
        }
        return layout
    }


}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text?.lowercased()
        self.performQuery(with: text)
    }
}


class DJCollectionViewCell: UICollectionViewCell {
    
    weak var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .lightGray
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
        let label = UILabel()
        label.textAlignment = .center
        label.frame = self.contentView.frame
        self.contentView.addSubview(label)
        self.label = label
    }
    
    func configure(text: String) {
        self.label?.text = text
    }
}
