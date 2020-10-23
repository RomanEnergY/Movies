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
    @IBOutlet weak var menuCollectionView: MenuCollectionView!
    
    //MARK: - public var
    public var viewModel: MainViewModelProtocol?
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MoviesGO"
        
        bindViewModel()
        bindMenuCollectionView()
        bindGroupCollectionView()
        viewModel?.initialStartData()
    }
    
    //MARK: - private func
    private func setupCollectionView(collectionView: UICollectionView, identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bindViewModel() {
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
    
    private func bindMenuCollectionView() {
        menuCollectionView.movies = { [weak self] in
            self?.viewModel?.movies ?? []
        }
        
        menuCollectionView.initialImage = { [weak self] iconString, complition in
            guard let self = self else { return }
            self.viewModel?.getIcon(posterPath: iconString) { data in
                complition(data)
            }
        }
        
        menuCollectionView.showeDetail = { [weak self] movie in
            self?.viewModel?.showeDetail(movie: movie)
        }
        
        menuCollectionView.beginBatchFetch = { [weak self]  complition in
            self?.viewModel?.beginBatchFetch {
                complition()
            }
        }
    }
    
    private func bindGroupCollectionView() {
        let nib = UINib(nibName: GroupCollectionViewCellConst.name, bundle: nil)
        groupCollectionView.register(nib, forCellWithReuseIdentifier: GroupCollectionViewCellConst.name)
        
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
}

//MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if var viewModel = viewModel {
            viewModel.selectedGroup = viewModel.groups?[indexPath.row]
            groupCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

//MARK: -MainView: UICollectionViewDelegateFlowLayout
extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        
        if let title = viewModel?.groups?[indexPath.row].rawValue {
            let width = title.widthOfString(usingFont: UIFont.systemFont(ofSize: 17))
            size = CGSize(width: width + 20, height: 30)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
