//
//  ViewController.swift
//  Network Layer
//
//  Created by MIN SEONG KIM on 2021/05/25.
//

import UIKit

class ViewController: UIViewController {

    var networkManager = NetworkManager()
    override func viewDidLoad() {
        view.backgroundColor = .green
        networkManager.getNewMovies(word: "타짜") { (movie, error) in
            let a = movie!
            for i in a {
                print(i.title)
            }
        }
    }


}

