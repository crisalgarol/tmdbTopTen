//
//  DashboardMovies.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

class DashboardMoviesPresenter: DashboardMoviesProtocol {
    
    let moviesDataServices: TopTenNetworkingServices
    var topTenMovies = [Movie]()
    
    required init(moviesDataServices: TopTenNetworkingServices) {
        self.moviesDataServices = moviesDataServices
    }
    
    func fetchMovieData () {
        
        moviesDataServices.fetchData { [unowned self] (movies) in
            
            self.topTenMovies = movies
            /*
             self.topTenMovies = movies
                    DispatchQueue.main.async {
                        self.moviesTableView.reloadData()
                        UIView.animate(withDuration: 0.8) {
                            self.moviesTableView.alpha = 1.0
                        }
                    }
             */
            
        }
        
    }
    
    func getItemsCount() -> Int {
        return topTenMovies.count
    }
    
    func getMovieElement(at index: Int) -> Movie {
        return topTenMovies[index]
    }
    
    
   
}
