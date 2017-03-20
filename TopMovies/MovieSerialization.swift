//
//  movieSerialization.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/18/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit
import Foundation

public final class MovieSerialization {
    
    typealias dict = [String:AnyObject]
    
    public enum MovieErrors: Error {
        case noTitle
        case noRelease
        case noPrice
        case noImage
        case noStore
        case noTrailer
    }
    
    static func returnMovies(data: Data) throws -> [Movies] {
        var arrMovies: [Movies] = []

        do {
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as? dict
            
            let entry = json?["feed"]!["entry"]! as! NSArray
            
            for i in 0..<entry.count {
                let category = entry[i] as! dict
                
                //Image property
                let fetchImage = (category["im:image"]![2] as! dict)
                
                guard let image = URL(string: fetchImage["label"] as! String) else {
                    throw MovieErrors.noImage
                }
                
                let imageData = NSData(contentsOf: image)
                let picture = UIImage(data: imageData as! Data)
                
                //Name Property
                guard let name = category["im:name"]!["label"] as? String else {
                    throw MovieErrors.noTitle
                }
                
                //Price Property
                guard let cost = category["im:price"]!["label"] as? String else {
                    throw MovieErrors.noPrice
                }
                
                //Release Property
                guard let releaseDate = category["im:releaseDate"]!["label"] as? String else {
                    throw MovieErrors.noRelease
                }

                //App Store Property
                let appUrl = (category["link"]![0] as! dict)
                guard let getHref = appUrl["attributes"]?["href"] as? String else {
                    throw MovieErrors.noStore
                }
                
                //Trailer Property
                let trailer = (category["link"]![1] as! dict)
                guard let href = trailer["attributes"]?["href"] as? String else {
                    throw MovieErrors.noTrailer
                }
                
                //Instance of a Movie
                let createMovie = Movies(title: name, release: releaseDate, price: cost, image: picture!, trailerUrl: href, storeUrl: getHref)
                
                arrMovies.append(createMovie)
            }
        }
        return arrMovies
    }
}
