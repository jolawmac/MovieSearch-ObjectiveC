//
//  MovieSearchTableViewCell.swift
//  MovieSearch
//
//  Created by Josh "McAbs" McDonald on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
    // MARK: - Properties
    
    var movies: DMNMovie? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Functions
    
    func updateViews() {
        
        guard let movie = self.movies else { return }
        self.movieTitleLabel.text = movie.title
        self.movieRatingLabel.text = "\(movie.rating)"
        self.movieOverviewTextView.text = movie.overview
        
        DMNMovieController.fetchPosterImage(movie.posterImage, completion: { (image) in
            DispatchQueue.main.async {
                self.postImageView.image = image
            }
        })
    }
}
