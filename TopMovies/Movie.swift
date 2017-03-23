//
//  Movies.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/18/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    let title: String
    let release: String
    let price: String
    let image: UIImage?
    let storeUrl: String
    
    init(title: String, release: String, price: String, image: UIImage?, storeUrl: String) {
        self.title = title
        self.release = release
        self.price = price
        self.image = image
        self.storeUrl = storeUrl
    }
    
}
