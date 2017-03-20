//
//  ViewController.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/17/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit
import Alamofire

class MyTableViewController: UITableViewController {
    
    let urlStr = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    var arrayMov: [Movies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJson(url: urlStr)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJson(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            try! self.arrayMov = MovieSerialization.returnMovies(data: response.data!)
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMov.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //Populate Image
        let imageView = cell?.viewWithTag(1) as! UIImageView
        imageView.image = arrayMov[indexPath.row].image
        
        //Populate Price
        let priceMovie = cell?.viewWithTag(4) as! UILabel
        priceMovie.text = arrayMov[indexPath.row].price
        
        //Populate Name
        let movieName = cell?.viewWithTag(2) as! UILabel
        let title = arrayMov[indexPath.row].title
        
        if (title.characters.count > 25) {
            let titleDisplay = title.getSubstring(long: title, x: 25)
            movieName.text = "\(titleDisplay)..."
        }
            
        else {
            movieName.text = title
        }
        
        //Populate Release Date
        let releaseDate = cell?.viewWithTag(3) as! UILabel
        let cutDate = arrayMov[indexPath.row].release
        
        let toDisplay = cutDate.getSubstring(long: cutDate, x: 10)
        releaseDate.text = toDisplay
        
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexRow = self.tableView.indexPathForSelectedRow?.row
        
        let destination = segue.destination as! InfoViewController
        let selected = arrayMov[indexRow!]
        destination.segueImage = selected.image
        destination.segueTitle = selected.title
        destination.seguePrice = selected.price
        destination.segueRelease = selected.release.getSubstring(long: selected.release, x: 10)
        destination.segueURL = selected.trailerUrl
        destination.segueStore = selected.storeUrl
        print(selected.storeUrl)
    }
}

extension String {
    func getSubstring(long: String, x: Int) -> String{
        let index = long.index(long.startIndex, offsetBy: x)
        let newString = long.substring(to: index)
        
        return newString
    }
}

