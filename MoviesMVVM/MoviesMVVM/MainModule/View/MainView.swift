//
//  MainView.swift
//  MoviesMVVM
//
//  Created by 1234 on 18.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

//MARK: - MainView: UIViewController
class MainView: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var groupCollectionView: UICollectionView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    //MARK: - public var
    public var viewModel: MainViewModelProtocol?
    
    //MARK: - privar var
    private var fetchingMorePage = false
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        
        setupCollectionView(collectionView: groupCollectionView, identifier: GroupCollectionViewCellConst.name)
        setupCollectionView(collectionView: menuCollectionView, identifier: MenuCollectionViewCellConst.name)
        
        bind()
        viewModel?.initialStartData()
    }
    
    //MARK: - private func
    private func setupCollectionView(collectionView: UICollectionView, identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bind() {
        viewModel?.menuCollectionViewReloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.menuCollectionView.reloadData()
            }
        }
        
        viewModel?.groupCollectionViewReloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.groupCollectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems = 0
        
        if collectionView == groupCollectionView {
            numberOfItems = viewModel?.groups?.count ?? 0
            
        } else if collectionView == menuCollectionView {
            numberOfItems = viewModel?.movies?.count ?? 0
            
        }
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellForItem = UICollectionViewCell()
        
        if collectionView == groupCollectionView {
            cellForItem = createGroupCollectionViewCell(indexPath)
            
        } else if collectionView == menuCollectionView {
            cellForItem = createMenuCollectionViewCell(indexPath)
            
        }
        
        return cellForItem
    }
    
    //MARK: - private func
    private func createGroupCollectionViewCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = groupCollectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCellConst.name, for: indexPath) as? GroupCollectionViewCell {
            
            // устанавливаем данные в ячейку
            if let group = viewModel?.groups?[indexPath.row] {
                cell.config(title: group.rawValue, isSelected: viewModel?.selectedGroup == group)
                
                return cell
            }
        } else {
            print("Error createGroupCollectionViewCell")
        }
        
        return UICollectionViewCell()
    }
    
    private func createMenuCollectionViewCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCellConst.name, for: indexPath) as? MenuCollectionViewCell {
            
            if let movies = viewModel?.movies {
                // устанавливаем данные в ячейку
                let movie = movies[indexPath.row]
                cell.setupDataCell(movie: movie)
                
                // устанавливаем картинку в ячейку
                if let iconString = movie.iconString {
                    // проверяем наличие кэшированной картинки
                    initialImage(iconString, indexPath, cell)
                }
            }
            
            configureCell(cell)
            return cell
            
        } else {
            print("Error createCellForItemMenuCollectionView")
        }
        
        return UICollectionViewCell()
    }
    
    private func initialImage(_ iconString: String, _ indexPath: IndexPath, _ cell: MenuCollectionViewCell) {
        viewModel?.getIcon(posterPath: iconString) { data in
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.setupImageCell(image: image)
                }
            }
        }
    }
    
    private func configureCell(_ cell: UICollectionViewCell) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 0.9
        cell.layer.masksToBounds = false
    }
}

//MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == groupCollectionView {
            
            if var viewModel = viewModel {
                viewModel.selectedGroup = viewModel.groups?[indexPath.row]
                groupCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }

        } else if collectionView == menuCollectionView {
            if let movie = viewModel?.movies?[indexPath.item] {
                viewModel?.showeDetail(movie: movie)
            }
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === groupCollectionView {
            
        } else if scrollView === menuCollectionView {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if (contentHeight - offsetY) < menuCollectionView.frame.height * 2 {
                beginBatchFetch()
            }
        }
    }
    
    public func beginBatchFetch() {
        if !fetchingMorePage {
            fetchingMorePage = true

            viewModel?.beginBatchFetch { [weak self] in
                self?.fetchingMorePage = false
            }
        }
    }
}

//MARK: -MainView: UICollectionViewDelegateFlowLayout
extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        
        if collectionView == groupCollectionView {
            if let title = viewModel?.groups?[indexPath.row].rawValue {
                let width = title.widthOfString(usingFont: UIFont.systemFont(ofSize: 17))
                size = CGSize(width: width + 20, height: 30)
            }

        } else if collectionView == menuCollectionView {
            let width = UIScreen.main.bounds.width - 20.0
            size = CGSize(width: width, height: width/2)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        var minimumLine = 0
        
        if collectionView == groupCollectionView {
            
            
        } else if collectionView == menuCollectionView {
            minimumLine = 10
        }
        
        return CGFloat(minimumLine)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edgeInsets = UIEdgeInsets()
        
        if collectionView == groupCollectionView {
            edgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        } else if collectionView == menuCollectionView {
            edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        return edgeInsets
    }
}
