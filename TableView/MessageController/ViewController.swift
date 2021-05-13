//
//  ViewController.swift
//  TableView
//
//  Created by MIN SEONG KIM on 2021/05/08.
//

import UIKit

class ViewController: UIViewController {

    var filteredName: [String] = []
    var filteredMessage: [String] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorInset.left = 76
            self.tableView.tableFooterView = UIView()
            self.tableView.register(UINib(nibName: "MailCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        }
    }
    
//    @IBOutlet private weak var searchBar: UISearchBar! {
//        didSet {
//            self.searchBar.delegate = self
//            self.searchBar.backgroundImage = UIImage()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        
        searchController.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        
//        // navigationbar 선없애기
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = false

        filteredName = Message.name
        filteredMessage = Message.message
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? MailCell else { fatalError("cell not found") }
        
        cell.configure(nameNumber: filteredName[indexPath.row], messageContent: filteredMessage[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredName.count
    }
    
//    // swipe to delete
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            filteredName.remove(at: indexPath.row)
//            filteredMessage.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        }
//        else if editingStyle == .insert {
//
//        }
//    }
//
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // cell 클릭 후 회색 잔상 안남기기
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pin = UIContextualAction(style: .normal, title: "Pin") { (_, _, success: @escaping (Bool) -> Void) in
                    print("Pin Clicked")
                    success(true)
        }
        pin.backgroundColor = .orange
        pin.image = UIImage(systemName: "pin.fill")
        
        return UISwipeActionsConfiguration(actions: [pin])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let alarm = UIContextualAction(style: .normal, title: "Alarm") { (_, _, succes: @escaping (Bool) -> Void) in
            print("Alarm Clicked")
            succes(true)
        }
        alarm.backgroundColor = .purple
        alarm.image = UIImage(systemName: "bell.slash.fill")
        
        let delete = UIContextualAction(style: .normal, title: "delete") { (_, _, success: @escaping (Bool) -> Void) in
            self.filteredName.remove(at: indexPath.row)
            self.filteredMessage.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
        }
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete, alarm])
    }
    
//     셀 높이 지정해서 title이 같이 나오게 할 수 있음
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// 검색 기능
// extension ViewController: UISearchBarDelegate {
//    // 검색 창 안의 텍스트가 여기 안의 코드를 실행
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        filteredName = []
//        filteredMessage = []
//
//        if searchText == "" {
//            filteredName = Message.name
//            filteredMessage = Message.message
//
//        } else {
//            for names in 0..<Message.name.count {
//                if Message.name[names].lowercased().contains(searchText.lowercased()) {
//                    filteredName.append(Message.name[names])
//                    filteredMessage.append((Message.message[names]))
//                }
//            }
//
//
//        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//
//    }
// }

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredName = []
        filteredMessage = []

        // searchController의 searchBar
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        
        if text.isEmpty {
            filteredName = Message.name
            filteredMessage = Message.message
        } else {
            for names in 0..<Message.name.count {
                if Message.name[names].lowercased().contains(text.lowercased()) {
                    filteredName.append(Message.name[names])
                    filteredMessage.append((Message.message[names]))
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
