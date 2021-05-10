//
//  ViewController.swift
//  SettingTableView
//
//  Created by MIN SEONG KIM on 2021/05/10.
//

import UIKit


class ViewController: UIViewController {

    

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource  = self
            self.tableView.delegate = self
            self.tableView.separatorInset.left = 63
            self.tableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
            self.tableView.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "SwitchTableViewCell")
            self.tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTabelViewCell")
        }
    }
    
    
    
    var model = [Section]()
    
    var filteredArr: [Any] = []
 
    let searchController = UISearchController(searchResultsController: nil)
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // searchController를 네비게이션바 안에 넣기(네비게이션 아이템으로 넣기)
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchController
//        searchController.delegate = self
        
        
//        searchController.obscuresBackgroundDuringPresentation = false
    }
    
}
    
extension ViewController: UITableViewDataSource {
    
    // section title 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = K.model[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.isFiltering ? 1 : K.model.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ?  self.filteredArr.count : K.model[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFiltering {
            let model = self.filteredArr[indexPath.row]
            if model is Data {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
                
                // cell data에 따라 변경
                cell.title.text = (model as! Data).title
                cell.iconImage.image = (model as! Data).icon
                cell.iconBackgroundImage.backgroundColor = (model as! Data).iconBackgroundColor
                
                return cell
                
            } else if model is SwitchData {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
                
                cell.title.text = (model as! SwitchData).title
                cell.iconImage.image = (model as! SwitchData).icon
                cell.iconBackgroundImage.backgroundColor = (model as! SwitchData).iconBackgroundColor
                cell.switch.isOn = (model as! SwitchData).isOn
                
                return cell
            }
            
        }
        let model = K.model[indexPath.section].data[indexPath.row]
        
        // switch 셀인지 static 셀인지에 따라 다르게 설정
        switch model.self{
        case .staticCell(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
            
       
            // cell data에 따라 변경
            cell.title.text = model.title
            cell.iconImage.image = model.icon
            cell.iconBackgroundImage.backgroundColor = model.iconBackgroundColor
            
            return cell
            
        case .switchCell(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            
            cell.title.text = model.title
            cell.iconImage.image = model.icon
            cell.iconBackgroundImage.backgroundColor = model.iconBackgroundColor
            cell.switch.isOn = model.isOn
            
            return cell
        }
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 클릭 후 회색잔상 안남기기
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
extension ViewController: UISearchResultsUpdating {


    // text가 업데이트 될 때 마다 불리는 함수
    func updateSearchResults(for searchController: UISearchController) {

        guard let text = searchController.searchBar.text?.lowercased() else { return }
        
        filteredArr = []
        
        print(text)
        
        for section in K.model {
            for dataIndex in 0..<section.data.count {
                let model = section.data[dataIndex]

                switch model.self {
                case .staticCell(let model):
                    if model.title.lowercased().contains(text) {
                        self.filteredArr.append(model)
                    }
                case .switchCell(let model):
                    if model.title.lowercased().contains(text) {
                        self.filteredArr.append(model)
                    }
                }

            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

    
    
