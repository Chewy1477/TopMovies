//
//  InfoViewModel.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/21/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import Foundation
import UIKit

protocol InfoViewProtocol {
    var movieTitle: String { get }
    var moviePrice: String { get }
    var movieRelease: String { get }
    var movieImage: UIImage? { get }
    var movieApp: String { get }
}

class InfoViewModel: InfoViewProtocol {
    private let infoMovie: Movie
    
    var movieTitle: String {
        return infoMovie.title
    }
    
    var moviePrice: String {
        return infoMovie.price
    }
    
    var movieRelease: String {
        let date = infoMovie.release
        let toDisplay = date.getSubstring(long: date, x: 10)
        
        return toDisplay
    }
    
    var movieImage: UIImage? {
        return infoMovie.image
    }
    
    var movieApp: String {
        return infoMovie.storeUrl
    }
    
    init(withMovie movie: Movie) {
        self.infoMovie = movie
    }
}
