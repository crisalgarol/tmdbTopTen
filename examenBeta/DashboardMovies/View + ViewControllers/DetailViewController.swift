//
//  DetailViewController.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailMoviesViewProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsControl: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: DetailMoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.delegate = self
        
        presenter?.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
 
        
    }
    
    //Clean the UI for the first launch
    func setupUI(){
        titleLabel.text = ""
        starsControl.text = ""
        posterImage.alpha = 0.0
        releaseDateLabel.text = ""
        ratingLabel.text = ""
        descriptionLabel.text = ""
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.tintColor = UIColor.red
        
    }
    
    //Updates the UI with a given Movie Object
    func updateUI(withMovie movie: Movie){
        titleLabel.text = movie.title
        starsControl.text = presenter?.calculateStarsRaiting()
        releaseDateLabel.text = "Fecha de lanzamiento: \(movie.releaseDate)"
        ratingLabel.text = "Rating: \(movie.rating)"
        descriptionLabel.text = movie.description
        posterImage.loadImageFromURL(url: NetworkingConstants.baseURLImages + movie.posterURL)
        
    }
    

}
