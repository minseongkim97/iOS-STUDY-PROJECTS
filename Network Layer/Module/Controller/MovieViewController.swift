//
//  MovieViewController.swift
//  Network Layer
//
//  Created by MIN SEONG KIM on 2021/05/25.
//

import UIKit
import SafariServices

class MovieViewController: UIViewController {
    
    var text: String = ""
    var movies: [Movie] = []
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = text
    }
}

extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { fatalError("error") }
        
        let movie = movies[indexPath.row]
        let imageURL = URL(string: movie.imageURL)
        do {
            let data = try Data(contentsOf: imageURL!)
            cell.configure(poster: UIImage(data: data),
                           titleNPubdate: "\(movie.title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: ""))(\(movie.pubDate))",
                           rate: "평점 \(movie.userRating)",
                           director: "감독 \(movie.director)",
                           actors: "출연 배우 \(movie.actors)")
        } catch {
            fatalError()
        }

        
        return cell
    }
    
    
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let link = movies[indexPath.row].link
        if let url = URL(string: link) {
            let svc = SFSafariViewController(url: url)
            self.present(svc, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}
