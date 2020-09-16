//
//  MenuCollectionViewCell.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelTitel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    //MARK: - override func
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.labelTitel.text = ""
        self.labelRating.text = ""
        self.releaseDateLabel.text = ""
        self.imageView.image = nil
    }
    
    //MARK: - public func
    public func setupDataCell(movie: MainMovieProtocol) {
        self.labelTitel.text = movie.title
        self.labelRating.text = "\(movie.rating)"
        self.releaseDateLabel.text = "\(movie.releaseDate)"
    }
    
    public func setupImageCell(image: UIImage) {
        self.imageView.image = image
    }
}
