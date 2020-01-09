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
    
    //Handles Services call for fetching data and processing the return movies list
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
    
    // Returns the number of total items
    func getItemsCount() -> Int {
        return topTenMovies.count
    }
    
    // returns a Movie element by index
    func getMovieElement(at index: Int) -> Movie {
        return topTenMovies[index]
    }
    
    // Set the selected movie into the class
    func setSelectedMovie(withMovie selectedItem: Movie) {
        self.selectedItem = selectedItem
    }
    
    // Returns the previous selected movie
    func getSelectedMovie() -> Movie {
        guard let selectedItem = selectedItem else {
            return Movie(title: "", posterURL: "", releaseDate: "", backdropImageURL: "", ID: -1, rating: 0.0, description: "")
        }
        return selectedItem
    }
    
    //Checks if must fetch data from the server evaluating the 24 hours condition if not, it loads the info from disk
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
