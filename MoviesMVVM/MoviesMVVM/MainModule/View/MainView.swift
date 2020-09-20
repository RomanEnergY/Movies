//
//  MainView.swift
//  MoviesMVVM
//
//  Created by 1234 on 18.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

//MARK: - Enum
enum MainViewCellConst {
    static let menuCell = "MenuCollectionViewCell"
}

//MARK: - MainView: UIViewController
class MainView: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - public var
    public var viewModel: MainViewModelProtocol?
    public var router: ModuleRouterProtocol?
    
    //MARK: - privar var
    private var cachingIndexPathImage: [String: UIImage] = [:]
    private var fetchingMorePage = false

    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        
        setupCollectionView()
        bind()
    }
    
    //MARK: - private func
    private func setupCollectionView() {
        let nib = UINib(nibName: "MenuCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MenuCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bind() {
        viewModel?.collectionViewReloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCellConst.menuCell, for: indexPath) as? MenuCollectionViewCell {
            
            if let movies = viewModel?.movies {
                // устанавливаем данные в ячейку
                let movie = movies[indexPath.row]
                cell.setupDataCell(movie: movie)
                
                // устанавливаем картинку в ячейку
                if let iconString = movie.iconString {
                    // проверяем наличие кэшированной картинки
                    if let cachingImage = cachingIndexPathImage[iconString] {
                        cell.setupImageCell(image: cachingImage)
                        
                    } else {
                        initialImage(iconString, indexPath, cell)
                    }
                }
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    private func initialImage(_ iconString: String, _ indexPath: IndexPath, _ cell: MenuCollectionViewCell) {
        viewModel?.getIcon(posterPath: iconString) { [weak self] data in
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
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModel?.movies?[indexPath.item] {
            viewModel?.showeDetail(movie: movie)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (contentHeight - offsetY) < collectionView.bounds.height * 2 {
            if !fetchingMorePage {
                fetchingMorePage = true

                viewModel?.beginBatchFetch { [weak self] in
                    self?.fetchingMorePage = false
                    print("movies.count", self?.viewModel?.movies?.count ?? 0)
                }
            }
        }
    }
}

//MARK: -MainView: UICollectionViewDelegateFlowLayout
extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 10
        let height = width/2
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
