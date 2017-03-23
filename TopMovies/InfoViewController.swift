//
//  InfoViewController.swift
//  TopMovies
//
//  Created by Chris Chueh on 3/19/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {

    var viewModel: InfoViewModel? {
        didSet {
            guard let ivm = viewModel else {
                return 
            }
            
            myTitle.text = ivm.movieTitle
            myImage.image = ivm.movieImage
            price.text = ivm.moviePrice
            release.text = ivm.movieRelease
            appButton.setTitle("App Store", for: .normal)
            
        }
    }
    
    fileprivate let appButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .black
        return button
    }()
    
    fileprivate var myImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var myTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var release: UILabel = {
        let date = UILabel()
        date.textAlignment = .left
        date.textColor = .black
        date.font = UIFont.systemFont(ofSize: 13)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    fileprivate var price: UILabel = {
        let cost = UILabel()
        cost.textAlignment = .left
        cost.textColor = .black
        cost.font = UIFont.systemFont(ofSize: 13)
        cost.translatesAutoresizingMaskIntoConstraints = false
        return cost
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private dynamic func appButtonTouchDown() {
        appButton.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        
        guard let ivm = viewModel else {
            return
        }
        
        guard let url = URL(string: ivm.movieApp) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func initialize() {
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        view.addSubview(appButton)
        view.addSubview(myTitle)
        view.addSubview(release)
        view.addSubview(price)
        view.addSubview(myImage)
        
        appButton.addTarget(self, action: #selector(InfoViewController.appButtonTouchDown), for: .touchDown)
        
        self.navigationController?.navigationBar.backgroundColor = .white
        
        view.addConstraint(NSLayoutConstraint(item: myImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: myImage, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 60))
        view.addConstraint(NSLayoutConstraint(item: myImage, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -60))
        view.addConstraint(NSLayoutConstraint(item: myImage, attribute: .height, relatedBy: .equal, toItem: myImage, attribute: .width, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: myTitle, attribute: .top, relatedBy: .equal, toItem: myImage, attribute: .bottom, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: myTitle, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 60))
        view.addConstraint(NSLayoutConstraint(item: myTitle, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -70))

        view.addConstraint(NSLayoutConstraint(item: release, attribute: .top, relatedBy: .equal, toItem: myTitle, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: release, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 60))
        view.addConstraint(NSLayoutConstraint(item: release, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -70))
        
        view.addConstraint(NSLayoutConstraint(item: price, attribute: .top, relatedBy: .equal, toItem: release, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: price, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 60))
        view.addConstraint(NSLayoutConstraint(item: price, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -70))
        
        view.addConstraint(NSLayoutConstraint(item: appButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: appButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: appButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: appButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: appButton, attribute: .top, relatedBy: .equal, toItem: appButton, attribute: .bottom, multiplier: 1, constant: -40))
    }
}
