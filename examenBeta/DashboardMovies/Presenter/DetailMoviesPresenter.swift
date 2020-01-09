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
    
    //A bridge for calling update UI into the View
    func updateUI() {
        delegate?.updateUI(withMovie: movie)
    }
    
    //Returns the number of start based on the rasting punctuation
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
    
    //Returns the movie 
    func getMovie() -> Movie {
        return self.movie
    }
    
    
}
