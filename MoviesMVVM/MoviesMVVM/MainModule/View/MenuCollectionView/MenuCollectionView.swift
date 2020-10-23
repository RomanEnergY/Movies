//
//  MenuCollectionViewDelegate.swift
//  MoviesMVVM
//
//  Created by 1234 on 20.10.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

class MenuCollectionView: UICollectionView {
    
    //MARK: - public var
    public var movies: (() -> [MainModelMovieProtocol])?
    public var initialImage: ((String, @escaping (Data) -> Void) -> Void)?
    public var showeDetail: ((MainModelMovieProtocol) -> Void)?
    public var beginBatchFetch: ((@escaping () -> Void) -> Void)?
    
    //MARK: - private var
    private var fetchingMorePage = false // для menuCollectionView - удалить
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let nib = UINib(nibName: MenuCollectionViewCellConst.name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: MenuCollectionViewCellConst.name)
        dataSource = self
        delegate = self
    }
}

extension MenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCellConst.name, for: indexPath) as? MenuCollectionViewCell {
            
            if let movies = movies?() {
                // устанавливаем данные в ячейку
                let movie = movies[indexPath.row]
                cell.setupDataCell(movie: movie)
                
                // устанавливаем картинку в ячейку
                if let iconString = movie.iconString {
                    initialImage?(iconString) { data in
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.setupImageCell(image: image)
                            }
                        }
                    }
                }
            }
            
            return cell
            
        } else {
            print("Error createCellForItemMenuCollectionView")
        }
        
        return UICollectionViewCell()
    }
}

extension MenuCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movies?()[indexPath.row] {
            self.showeDetail?(movie)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (contentHeight - offsetY) < frame.height * 2 {
            if !fetchingMorePage {
                fetchingMorePage = true
                beginBatchFetch?() { [weak self] in
                    self?.fetchingMorePage = false
                }
            }
        }
    }
}

extension MenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        
        let width = UIScreen.main.bounds.width - 20.0
        size = CGSize(width: width, height: width/2)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
