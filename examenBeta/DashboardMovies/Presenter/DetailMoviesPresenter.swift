//
//  DetailMoviesPresenter.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

class DetailMoviesPresenter: DetailMoviesPresenterProtocol {

    var movie: Movie
    weak var delegate: DetailMoviesViewProtocol?
    
    required init (withMovie movie: Movie) {
        self.movie = movie
    }
    
    func updateUI() {
        delegate?.updateUI(withMovie: movie)
    }
    
    func calculateStarsRaiting() -> String {
        let numberOfStars = Int(movie.rating/2)
        var stars = ""
        for i in 0..<5 {
            if( (i+1) <= numberOfStars ){
                stars += "⭐️"
            }else{
                stars += "⚪️"
            }
        }
        return stars
    }
    
    func getMovie() -> Movie {
        return self.movie
    }
    
    
}
