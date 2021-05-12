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

    
   
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorInset.left = 76
            self.tableView.tableFooterView = UIView()
            self.tableView.register(UINib(nibName: "MailCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        }
    }
    
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
            self.searchBar.backgroundImage = UIImage()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // navigationbar 선없애기
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false

      
    
        filteredName = Message.name
        filteredMessage = Message.message
     

    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MailCell
        cell.nameNumber.text = filteredName[indexPath.row]
        cell.messageContent.text = filteredMessage[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredName.count
    }
    
    // swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filteredName.remove(at: indexPath.row)
            filteredMessage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
              
        }
        else if editingStyle == .insert {
            
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // cell 클릭 후 회색 잔상 안남기기
        tableView.deselectRow(at: indexPath, animated: true)
    
        
    }
}

// 검색 기능
extension ViewController: UISearchBarDelegate {
    // 검색 창 안의 텍스트가 여기 안의 코드를 실행
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        filteredName = []
        filteredMessage = []
      
        if searchText == "" {
            filteredName = Message.name
            filteredMessage = Message.message
           
        } else {
            for names in 0..<Message.name.count {
                if Message.name[names].lowercased().contains(searchText.lowercased()) {
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
