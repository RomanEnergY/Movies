//
//  DescriptionViewController.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

enum DescriptionViewCellConst {
    static let imageCell = "ImageTableViewCell"
    static let overviewCell = "OverviewTableViewCell"
}

class DescriptionViewController: UIViewController {
    //MARK: - Types
    enum TypeCell {
        case image
        case title
        case tagline
        case overview
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public Properties
    public var idMovie: Int?
    public var posterPath: String?
    
    //MARK: - Private Properties
    private var arrayTypeCell: [TypeCell] = [.title, .image, .tagline, .overview]
    private var viewModel: DescriptionViewModelProtocol?
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    //MARK: - private func
    private func bind() {
        guard let idMovie = idMovie,
            let posterPath = posterPath else { return }
        
        viewModel = DescriptionViewModel(idMovie: idMovie, posterPath: posterPath)
        viewModel?.tableViewReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension DescriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch arrayTypeCell[indexPath.item] {
        case .image:
            if let imageCell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewCellConst.imageCell, for: indexPath) as? ImageTableViewCell {
                if let dataIcon = viewModel?.dataIcon {
                    imageCell.imgView.image = UIImage(data: dataIcon)
                }
                
                return imageCell
            }
        case .title:
            let titleCell = UITableViewCell()
            titleCell.textLabel?.text = viewModel?.descriptionMovie?.title
            return titleCell
            
        case .tagline:
            let taglineCell = UITableViewCell()
            taglineCell.textLabel?.text = viewModel?.descriptionMovie?.tagline
            return taglineCell
            
        case .overview:
            if let overviewCell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewCellConst.overviewCell, for: indexPath) as? OverviewTableViewCell {
                guard let overview = viewModel?.descriptionMovie?.overview else { return UITableViewCell() }
                overviewCell.overviewLabel.text = overview
                
                return overviewCell
            }
        }
        
        return UITableViewCell()
    }
}
