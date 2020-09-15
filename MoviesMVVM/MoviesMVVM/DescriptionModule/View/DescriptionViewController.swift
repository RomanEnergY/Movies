//
//  DescriptionViewController.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

protocol DescriptionViewProtocol: AnyObject {
    func tableViewReloadData()
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
    var presenter: DescriptionPresenterProtocol?
    
    //MARK: - Private Properties
    private var arrayTypeCell: [TypeCell] = [.title, .image, .tagline, .overview]
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DescriptionViewController: DescriptionViewProtocol {
    func tableViewReloadData() {
        tableView.reloadData()
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
            if let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageTableViewCell {
                if let dataIcon = presenter?.dataIcon {
                    imageCell.imgView.image = UIImage(data: dataIcon)
                }
                
                return imageCell
            }
        case .title:
            let titleCell = UITableViewCell()
            titleCell.textLabel?.text = presenter?.descriptionMovie?.title
            return titleCell
            
        case .tagline:
            let taglineCell = UITableViewCell()
            taglineCell.textLabel?.text = presenter?.descriptionMovie?.tagline
            return taglineCell
            
        case .overview:
            if let overviewCell = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as? OverviewTableViewCell {
                guard let overview = presenter?.descriptionMovie?.overview else { return UITableViewCell() }
                overviewCell.overviewLabel.text = overview
                
                return overviewCell
            }
        }
        
        return UITableViewCell()
    }
}
