//
//  DetailMoviesProtocol.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

protocol DetailMoviesPresenterProtocol {
    init (withMovie: Movie)
    func calculateStarsRaiting() -> String
    func getMovie() -> Movie
    func updateUI()
}
