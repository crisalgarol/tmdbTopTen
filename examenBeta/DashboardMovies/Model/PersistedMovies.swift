//
//  PersistedMovies.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

//Model for persist data into the disk
class PersistedMovies: Codable {
    
    let movies: [Movie]
    let fetchedDate: Date
    
    init(movies: [Movie], fetchedDate: Date){
        self.movies = movies
        self.fetchedDate = Date()
    }
    
}
