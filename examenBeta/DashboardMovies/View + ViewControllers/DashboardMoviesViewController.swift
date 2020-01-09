//
//  ViewController.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 08/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import UIKit

class DashboardMoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!

    let presenter: DashboardMoviesPresenter = DashboardMoviesPresenter(moviesDataServices: TopTenNetworkingServices())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        presenter.delegate = self
        setupView()
        
        presenter.checkSavedMovies()
    }
    
    //Configures the view for the first launch (not the first time the user opens the app)
    func setupView() {
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        moviesTableView.alpha = 0.0
    }


}

extension DashboardMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentMovie = presenter.getMovieElement(at: indexPath.row)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.titleLabel.isHidden = false
        cell.releaseDateLabel.isHidden = false
        cell.titleLabel.text = currentMovie.title
        cell.releaseDateLabel.text = currentMovie.releaseDate
        cell.selectedBackgroundView = backgroundView

        cell.poster.loadImageFromURL(url: NetworkingConstants.baseURLImages + currentMovie.posterURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        presenter.setSelectedMovie(withMovie: presenter.getMovieElement(at: indexPath.row))
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var detailView = segue.destination as? DetailViewController else {return}
        detailView.presenter = DetailMoviesPresenter(withMovie: presenter.getSelectedMovie())        
    }
    
    
    
}

extension DashboardMoviesViewController: DashboardMoviesViewProtocol {
    //Updates an animates the TableView
    func updateUI() {
         DispatchQueue.main.async {
             self.moviesTableView.reloadData()
             self.moviesTableView.alpha = 0.0
             UIView.animate(withDuration: 0.8) {
                 self.moviesTableView.alpha = 1.0
             }
         }
     }
}
