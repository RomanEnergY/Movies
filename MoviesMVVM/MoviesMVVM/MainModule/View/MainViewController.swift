//
//  ViewController.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

enum MainViewSegueConst {
    static let descriptionView = "descriptionViewController"
}

enum MainViewCellConst {
    static let menuCell = "menuCollectionViewCell"
}

final class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - privar var
    private var viewModel: MainViewModelProtocol?
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bind()
    }
    
    private func bind() {
        viewModel = MainViewModel()
        viewModel?.collectionViewReloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainViewSegueConst.descriptionView { //
            if let descriptionViewController = segue.destination as? DescriptionViewController {
                if let movie = sender as? Movie {
                    
                    descriptionViewController.idMovie = movie.id
                    descriptionViewController.posterPath = movie.posterPath
                    
//                    let viewModel = DescriptionViewModel(idMovie: movie.id, posterPath: movie.posterPath)
                    
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

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let menuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCellConst.menuCell, for: indexPath) as? MenuCollectionViewCell {
            
            guard let movies = viewModel?.movies else { return UICollectionViewCell() }
            
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
        let movie = viewModel?.movies[indexPath.item]
        self.performSegue(withIdentifier: MainViewSegueConst.descriptionView, sender: movie)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (contentHeight - offsetY) / contentHeight  < 0.3 {
            viewModel?.beginBatchFetch()
        }
    }
}
