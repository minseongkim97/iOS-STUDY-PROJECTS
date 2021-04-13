//
//  SecondCustomViewController.swift
//  STUDY-PROJECT
//
//  Created by MIN SEONG KIM on 2021/04/14.
//

import UIKit

class SecondCustomViewController: UIViewController {
    
    private let selectedItem: String
    private let relatedItem: [String]
    
   
    
    
    init(selectedItem: String, relatedItem: [String]){
        self.selectedItem = selectedItem
        self.relatedItem = relatedItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedItem.uppercased()
        view.backgroundColor = .systemGreen
        let itemLabel = UILabel(frame: view.bounds)
        view.addSubview(itemLabel)
        itemLabel.textAlignment = .center
        itemLabel.numberOfLines = -1
        
        for item in relatedItem {
            itemLabel.text = (itemLabel.text ?? "") + " " + item
        }
        
    }
    

}

