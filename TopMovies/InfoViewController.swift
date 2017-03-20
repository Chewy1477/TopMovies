//
//  InfoViewController.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/19/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class InfoViewController: UIViewController {
    
    var segueImage = UIImage()
    var segueTitle: String = ""
    var seguePrice: String = ""
    var segueRelease: String = ""
    var segueURL: String = ""
    var segueStore: String? = ""
    
    var videoPlayer = AVPlayer()
    var AVPlayerController = AVPlayerViewController()
    
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRelease: UILabel!
    @IBOutlet weak var moviePrice: UILabel!
    
    @IBAction func watchTrailer(_ sender: Any) {
        let fileURL = URL(string: segueURL)
        
        videoPlayer = AVPlayer(url: fileURL!)
        AVPlayerController.player = videoPlayer
        
        self.present(AVPlayerController, animated: true){
            self.AVPlayerController.player?.play()
        }
    }
    
    @IBAction func toStore(_ sender: Any) {
        let url = URL(string: segueStore!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        bigImage.image = segueImage
        movieTitle.text = segueTitle
        moviePrice.text = seguePrice
        movieRelease.text = segueRelease
    }
}
