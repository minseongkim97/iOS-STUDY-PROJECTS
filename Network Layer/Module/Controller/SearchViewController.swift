//
//  ViewController.swift
//  Network Layer
//
//  Created by MIN SEONG KIM on 2021/05/25.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            self.searchTextField.delegate = self
        }
    }
    
    var networkManager = NetworkManager()
    var movies: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MovieViewController else { return }
        vc.text = self.searchTextField.text ?? ""
        vc.movies = self.movies
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        networkManager.getNewMovies(word: searchTextField.text ?? "") { movie, error in
            self.movies = movie!
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Move", sender: self)
            }
        }
       
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
