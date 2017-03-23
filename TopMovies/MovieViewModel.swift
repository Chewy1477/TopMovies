//
//  MovieProtocol.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/20/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import Foundation
import UIKit

protocol MovieCellProtocol: AnyObject {
    var movieTitle: String { get }
    var moviePrice: String { get }
    var movieRelease: String { get }
    var movieImage: UIImage? { get }
}

class MovieTableViewCellViewModel: MovieCellProtocol {
    let theMovie: Movie
    
    var movieTitle: String {
        return theMovie.title
    }
    
    var moviePrice: String {
        return theMovie.price
    }
    
    var movieRelease: String {
        let date = theMovie.release
        let toDisplay = date.getSubstring(long: date, x: 10)
        
        return toDisplay
    }
    
    var movieImage: UIImage? {
        return theMovie.image
    }
    
    init(withMovie movie: Movie) {
        self.theMovie = movie
    }
}

typealias MovieTableViewModel = [MovieTableViewCellViewModel]

extension String {
    
    func getSubstring(long: String, x: Int) -> String{
        let index = long.index(long.startIndex, offsetBy: x)
        let newString = long.substring(to: index)
        
        return newString
    }
    
}
