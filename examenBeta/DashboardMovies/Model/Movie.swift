//
//  Movie.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 08/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

class Movie: Codable {
    
    let title: String
    let posterURL: String
    let releaseDate: String
    let backdropImageURL: String
    let ID: Int
    let rating: Double
    let description: String
    
    init(title: String, posterURL: String, releaseDate: String, backdropImageURL: String, ID: Int, rating: Double, description: String) {
        self.title = title
        self.posterURL = posterURL
        self.releaseDate = releaseDate
        self.backdropImageURL = backdropImageURL
        self.ID = ID
        self.rating = rating
        self.description = description
    }
    
}
