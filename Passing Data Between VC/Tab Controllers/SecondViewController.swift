//
//  SecondViewController.swift
//  Passing Data Between VC
//
//  Created by MIN SEONG KIM on 2021/04/15.
//

import UIKit

// Completiont handler model
class SecondViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name: -"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 100)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Set name", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        let textEntry = TextEntryViewController()
        textEntry.completion = { [weak self] text in
            DispatchQueue.main.async {
                self?.label.text = text
            }
        }
        let vc = UINavigationController(rootViewController: textEntry)
        present(vc, animated: true, completion: nil)
    }
    
}
