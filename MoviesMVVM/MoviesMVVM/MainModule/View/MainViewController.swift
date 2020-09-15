//
//  ViewController.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func collectionViewReloadData()
}

final class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - privar var
    private var presenter: MainPresenterProtocol?
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        presenter = MainPresenter(mainViewProtocol: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "descriptionViewController" { //
            if let descriptionViewController = segue.destination as? DescriptionViewController {
                if let movie = sender as? Movie {
                    
                    let presenter = DescriptionPresenter(descriptionViewProtocol: descriptionViewController,
                                                         idMovie: movie.id,
                                                         posterPath: movie.posterPath)
                    
                    descriptionViewController.presenter = presenter
                }
            }
        }
    }
    
    //MARK: - private func
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MainViewController: MainViewProtocol {
    func collectionViewReloadData() {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let menuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell {
            
            guard let movies = presenter?.movies else { return UICollectionViewCell() }
            
            let movie = movies[indexPath.row]
            
            menuCollectionViewCell.setupCell(movie: movie)
            return menuCollectionViewCell
        }
        
        return UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = presenter?.movies[indexPath.item]
        self.performSegue(withIdentifier: "descriptionViewController", sender: movie)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (contentHeight - offsetY) / contentHeight  < 0.3 {
            presenter?.beginBatchFetch()
        }
    }
}
