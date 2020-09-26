//
//  MenuCollectionViewCell.swift
//  MoviesMVVM
//
//  Created by 1234 on 18.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

//MARK: - Enum
enum MenuCollectionViewCellConst {
    static let name = "MenuCollectionViewCell"
}

class MenuCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var viewCell: UIView! {
        didSet {
            viewCell.layer.cornerRadius = 15
            viewCell.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var retingView: UIView! {
        didSet {
            retingView.layer.borderColor = UIColor.yellow.cgColor
            retingView.layer.borderWidth = 1
            retingView.layer.cornerRadius = 10
        }
    }
    
    //MARK: - override func
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameMovieLabel.text = ""
        ratingLabel.text = ""
        releaseDateLabel.text = ""
        overviewLabel.text = ""
    }
    
    //MARK: - public func
    public func setupDataCell(movie: MainModelMovieProtocol) {
        nameMovieLabel.text = movie.title
        overviewLabel.text = "\t\(movie.overview)"
        ratingLabel.text = "\(movie.rating)"
        
        guard let date = movie.releaseDate else { return }
        releaseDateLabel.text = dateFormatterString(date)
    }
    
    public func setupImageCell(image: UIImage) {
        imageView.image = image
    }
    
    //MARK: - private func
    private func dateFormatterString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: date)
    }
}
