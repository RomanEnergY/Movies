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
    @IBOutlet weak var imageView: UIImageView!  {
        didSet {
            imageView.layer.cornerRadius = 15
            imageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var labelRating: UILabel! {
        didSet {
            labelRating.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var labelTitel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - Private properties
    private var dicIdImage = [Int: UIImage]()
    private let modelData = ModelData()
    
    //MARK: - override func
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - public func
    
    public func setupCell(movie: Movie) {
        self.labelTitel.text = movie.title
        self.labelRating.text = "\(movie.rating)"
        self.releaseDateLabel.text = "\(movie.releaseDate)"
        self.imageView.image = nil
        
        if let image = dicIdImage[movie.id] {
            self.imageView.image = image
            
        } else {
            getImage(movie)
        }
    }
    
    private func getImage(_ movie: Movie) {
        modelData.getIcon(whith: 300, posterPath: movie.posterPath, completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let data):
                if let data = data {
                    let image = UIImage(data: data)
                    self?.dicIdImage[movie.id] = image
                    self?.imageView.image = image
                }
            }
        })
    }
}
