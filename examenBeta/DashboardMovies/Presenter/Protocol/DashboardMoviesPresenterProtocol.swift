//
//  DashboardMoviesProtocol.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

protocol DashboardMoviesPresenterProtocol {

    init(moviesDataServices: TopTenNetworkingServices)
    func fetchMovieData()
    func getItemsCount() -> Int
    func getMovieElement(at index: Int) -> Movie
    func setSelectedMovie(withMovie: Movie)
    func getSelectedMovie() -> Movie
    func checkSavedMovies()
}

