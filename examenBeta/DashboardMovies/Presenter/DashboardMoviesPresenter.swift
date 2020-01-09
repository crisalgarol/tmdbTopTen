//
//  DashboardMovies.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

class DashboardMoviesPresenter: DashboardMoviesPresenterProtocol {
        
    weak var delegate: DashboardMoviesViewProtocol?
    
    let moviesDataServices: TopTenNetworkingServices
    let savedMoviesFileName = "movies.json"

    var topTenMovies = [Movie]()
    var selectedItem: Movie?

    
    required init(moviesDataServices: TopTenNetworkingServices) {
        self.moviesDataServices = moviesDataServices
    }
    
    func fetchMovieData () {
        moviesDataServices.fetchData { [unowned self] (movies) in
            self.topTenMovies = movies
            self.delegate?.updateUI()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let moviesToSave = PersistedMovies(movies: movies, fetchedDate: Date())
                DiskStorage.saveToDisk(moviesToSave, withName: self.savedMoviesFileName)
            }
        }
    }
    
    func getItemsCount() -> Int {
        return topTenMovies.count
    }
    
    func getMovieElement(at index: Int) -> Movie {
        return topTenMovies[index]
    }
    
    func setSelectedMovie(withMovie selectedItem: Movie) {
        self.selectedItem = selectedItem
    }
    
    func getSelectedMovie() -> Movie {
        guard let selectedItem = selectedItem else {
            return Movie(title: "", posterURL: "", releaseDate: "", backdropImageURL: "", ID: -1, rating: 0.0, description: "")
        }
        return selectedItem
    }
    
    func checkSavedMovies() {
        
        if DiskStorage.fileExists(fileName: savedMoviesFileName) {
            
            guard let savedMovies = DiskStorage.getFromDisk(savedMoviesFileName, as: PersistedMovies.self) else { fetchMovieData(); return }
            
 
            if savedMovies.fetchedDate.timeIntervalSinceNow * -1 > 86400 {
                fetchMovieData()
            } else {
                self.topTenMovies = savedMovies.movies
                self.delegate?.updateUI()
            }
            
        } else {
            fetchMovieData()
        }
          
    }
    
    
   
}
