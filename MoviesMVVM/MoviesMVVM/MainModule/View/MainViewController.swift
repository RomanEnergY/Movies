//
//  ViewController.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

//MARK: - Enum
enum MainViewSegueConst {
    static let descriptionView = "descriptionViewController"
}

enum MainViewCellConst {
    static let menuCell = "menuCollectionViewCell"
    static let whithCell = 300
}

//MARK: MainViewController: UIViewController
final class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - privar var
    private var viewModel: MainViewModelProtocol?
    private var cachingIndexPathImage: [String: UIImage] = [:]
    private var fetchingMorePage = false
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bind()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainViewSegueConst.descriptionView { //
            if let descriptionViewController = segue.destination as? DescriptionViewController {
                if let movie = sender as? MovieAPI {
                    
                    descriptionViewController.idMovie = movie.id
                    descriptionViewController.posterPath = movie.posterPath
                }
            }
        }
    }
    
    //MARK: - private func
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bind() {
        viewModel = MainViewModel()
        viewModel?.collectionViewReloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let menuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCellConst.menuCell, for: indexPath) as? MenuCollectionViewCell {
            
            if let movies = viewModel?.movies {
                // устанавливаем данные в ячейку
                let movie = movies[indexPath.row]
                menuCollectionViewCell.setupDataCell(movie: movie)
                
                // устанавливаем картинку в ячейку
                if let iconString = movie.iconString {
                    // проверяем наличие кэшированной картинки
                    if let cachingImage = cachingIndexPathImage[iconString] {
                        menuCollectionViewCell.setupImageCell(image: cachingImage)
                        
                    } else {
                        initialImage(iconString, indexPath, menuCollectionViewCell)
                    }
                }
            }
            
            return menuCollectionViewCell
        }
        
        return UICollectionViewCell()
    }
    
    private func initialImage(_ iconString: String, _ indexPath: IndexPath, _ cell: MenuCollectionViewCell) {
        viewModel?.getIcon(whith: MainViewCellConst.whithCell, posterPath: iconString) { [weak self] data in
            if let image = UIImage(data: data) {
                // кэшируем картинку
                self?.cachingIndexPathImage[iconString] = UIImage(data: data)
                
                DispatchQueue.main.async {
                    cell.setupImageCell(image: image)
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel?.movies?[indexPath.item]
        self.performSegue(withIdentifier: MainViewSegueConst.descriptionView, sender: movie)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (contentHeight - offsetY) / contentHeight  < 0.4 {
            
            if !fetchingMorePage {
                fetchingMorePage = true
                
                viewModel?.beginBatchFetch { [weak self] in
                    self?.fetchingMorePage = false
                }
            }
        }
    }
}
