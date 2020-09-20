//
//  DescriptionViewController.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

//MARK: - enum
enum DescriptionViewCellConst {
    static let imageCell = "ImageTableViewCell"
    static let overviewCell = "OverviewTableViewCell"
}

//MARK: - DescriptionViewController: UIViewController
class DescriptionView: UIViewController {
    
    //MARK: - Types
    enum TypeCell {
        case image
        case title
        case tagline
        case overview
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private Properties
    private var arrayTypeCell: [TypeCell] = [.image, .title, .tagline, .overview]
    
    //MARK: - public var
    public var viewModel: DescriptionViewModelProtocol?
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    //MARK: - private func
    private func bind() {
        viewModel?.tableViewReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension DescriptionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let descriptionMovie = viewModel?.descriptionMovie
        
        switch arrayTypeCell[indexPath.item] {
        case .image:
            if let imageCell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewCellConst.imageCell,
                                                             for: indexPath) as? ImageTableViewCell {
            if let dataIcon = viewModel?.dataIcon {
                imageCell.imgView.image = UIImage(data: dataIcon)
            }
            
            return imageCell
            }
        case .title:
            let titleCell = UITableViewCell()
            titleCell.backgroundColor = UIColor.clear
            titleCell.textLabel?.textAlignment = .center
            
            titleCell.textLabel?.text = descriptionMovie?.title
            return titleCell
            
        case .tagline:
            let taglineCell = UITableViewCell()
            taglineCell.backgroundColor = UIColor.clear
            taglineCell.textLabel?.textAlignment = .center
            
            taglineCell.textLabel?.text = descriptionMovie?.tagline
            return taglineCell
            
        case .overview:
            if let overviewCell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewCellConst.overviewCell,
                                                                for: indexPath) as? textTableViewCell {
                guard let overview = descriptionMovie?.overview else { return UITableViewCell() }
                overviewCell.label.text = overview
                
                return overviewCell
            }
        }
        
        return UITableViewCell()
    }
}
