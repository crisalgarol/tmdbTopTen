//
//  ViewController.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 08/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    var topTenMovies = [Movie]()
    var selectedItem: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.alpha = 0.0
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        fetchData { [unowned self] (movies) in
            self.topTenMovies = movies
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
                UIView.animate(withDuration: 0.8) {
                    self.moviesTableView.alpha = 1.0
                }
            }
        }
    }
    
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topTenMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = topTenMovies[indexPath
            .row]
        
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.titleLabel.isHidden = false
        cell.releaseDateLabel.isHidden = false
        cell.titleLabel.text = currentMovie.title
        cell.releaseDateLabel.text = currentMovie.releaseDate
        
        cell.poster.loadImageFromURL(url: NetworkingConstants.baseURLImages + currentMovie.posterURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedItem = topTenMovies[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var detailView = segue.destination as? DetailViewController else {return}
        detailView.movie = selectedItem
        
    }
    
    
    
}

