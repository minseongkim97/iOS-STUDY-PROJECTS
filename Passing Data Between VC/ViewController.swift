//
//  ViewController.swift
//  Passing Data Between VC
//
//  Created by MIN SEONG KIM on 2021/04/14.
//

import UIKit

/*
 - Custom init
 - Completion handler (closure)
 - NotificationCenter post
 */

class ViewController: UIViewController {
    
    private let data = [
        ["apple", "sony", "google", "microsoft"],
        ["one","two","three","four"],
        ["UK","ROK","Canada","USA"]
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }


}


extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        return cell
    }
}

    
    


extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let items = data[indexPath.section]
        let vc = SecondCustomViewController(selectedItem: items[indexPath.row], relatedItem: items)
       present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}


