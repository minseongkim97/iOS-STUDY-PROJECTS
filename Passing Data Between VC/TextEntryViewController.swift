//
//  TextEntryViewController.swift
//  Passing Data Between VC
//
//  Created by MIN SEONG KIM on 2021/04/15.
//

import UIKit

class TextEntryViewController: UIViewController {
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Name..."
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
    
    public var completion: ((String?)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Name"
        view.backgroundColor = .lightGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        view.addSubview(field)
        
        field.frame = CGRect(x: 20, y: 100, width: view.frame.size.width - 40, height: 55)
        field.becomeFirstResponder()
    }
    
    @objc private func didTapDoneButton(){
        completion?(field.text)
        dismiss(animated: true, completion: nil)
    }
}
