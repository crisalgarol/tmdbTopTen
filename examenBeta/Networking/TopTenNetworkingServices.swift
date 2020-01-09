//
//  TopTenNetworkingServices.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

class TopTenNetworkingServices {
    
    //Fetches de data from the composed URL and returns a list with Movie objects asynchronously
    
    func fetchData(completionHandler: @escaping ([Movie]) -> Void )  {
           
           let movieSession = URLSession.shared
           var movies = [Movie]()
           
           guard var topTenURLComposed = URLComponents(string: NetworkingConstants.baseURL) else {return}
           let queryItems = [
               URLQueryItem(name: "api_key", value: NetworkingConstants.apiKey),
               URLQueryItem(name: "language", value: NetworkingConstants.spanishLanguage)
                     ]
           
           topTenURLComposed.path = "/3" + Endpoints.movie + Endpoints.topRated
           topTenURLComposed.queryItems = queryItems
                   
           DispatchQueue.global(qos: .userInitiated).async {
               movieSession.dataTask(with: topTenURLComposed.url!) { (data, response, error) in
                   
                   if let data = data {
                       let jsonDecoder = JSONDecoder()
                       let decodedResponse = try? jsonDecoder.decode(TopTenResponse.self, from: data)
                       
                       if let ml = decodedResponse?.results {
                           
                           let movieList = ml[..<10]
                           
                           for i in 0..<movieList.count {
                               let movie = movieList[i]
                               guard let title = movie.title else {break}
                               guard let posterURL = movie.posterPath else {break}
                               guard let backdropImageURL = movie.backdropPath else {break}
                               guard let movieID = movie.id else {break}
                               guard let releaseDate = movie.releaseDate else {break}
                               guard let rating = movie.voteAverage else {break}
                               guard let description = movie.overview else {break}
                               
                               movies.append(Movie(title: title, posterURL: posterURL, releaseDate: releaseDate, backdropImageURL: backdropImageURL, ID: movieID, rating: rating, description: description))
                           }
                           
                           completionHandler(movies)
                           
                       }
                   
                       
                   }
               }.resume()
           }
           

           
       }

}
