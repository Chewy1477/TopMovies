//
//  ViewController.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/17/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit
import Alamofire

class MyTableViewController: UIViewController {
    
    let urlStr = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    var tableViewModel: MovieTableViewModel?
    var movies: [Movie] = []
    
    fileprivate let topMoviesTable: UITableView = {
        let view = UITableView()
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.description())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top Movies!"
        initialize()
        getJson(url: urlStr)
    }

    func initialize() {
        
        view.addSubview(topMoviesTable)
        topMoviesTable.delegate = self
        topMoviesTable.dataSource = self
        
        view.addConstraint(NSLayoutConstraint(item: topMoviesTable, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: topMoviesTable, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: topMoviesTable, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: topMoviesTable, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
        
    }
    
    func getJson(url: String) {
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            guard let data = response.data else {
                return
            }
            
            try? self.movies = MovieSerialization.movies(data: data)
            
            self.tableViewModel = self.movies.map({(parameter: Movie) -> MovieTableViewCellViewModel in
                return MovieTableViewCellViewModel(withMovie: parameter)
            })
            
            self.topMoviesTable.reloadData()
        })
    }
    
}

extension MyTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.description(), for: indexPath)
        guard let vm = tableViewModel else {
            return cell
        }

        (cell as? MovieTableViewCell)?.cellViewModel = vm[indexPath.row]
        
        cell.backgroundColor = UIColor.white

        return cell
    }

}

extension MyTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let vm = tableViewModel else {
            return 0
        }
        return vm.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let infoViewController = InfoViewController()

        guard let vm = tableViewModel else {
            return
        }
        
        infoViewController.viewModel = InfoViewModel(withMovie: vm[indexPath.row].theMovie)
        navigationController?.pushViewController(infoViewController, animated: true)
    }
    
}

