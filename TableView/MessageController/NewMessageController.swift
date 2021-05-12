//
//  NewMessageController.swift
//  TableView
//
//  Created by MIN SEONG KIM on 2021/05/09.
//

import UIKit

class NewMessageController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            // 돋보기 없애기
            searchBar.setImage(UIImage(), for: .search, state: .normal)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
