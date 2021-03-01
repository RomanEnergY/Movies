//
//  ShadowRoundView.swift
//  Movies
//
//  Created by Roman Zverik on 19.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class ShadowRoundView: BaseView {
	
	private var contentView = UIView()
	var shadowColor: UIColor = .black {
		didSet {
			updateView()
		}
	}
	var shadowOffset: CGSize = .zero {
		didSet {
			updateView()
		}
	}
	var shadowOpacity: CGFloat = 1.0 {
		didSet {
			updateView()
		}
	}
	var shadowRadius: CGFloat = 10.0 {
		didSet {
			updateView()
		}
	}
	var cornerRadius: CGFloat = 10.0 {
		didSet {
			updateView()
		}
	}
	
	func wrap(view content: UIView) {
		contentView = content
		addSubview(contentView)
		contentView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		updateView()
	}
	
	//MARK: - private function
	
	private func updateView() {
		layer.backgroundColor = UIColor.clear.cgColor
		layer.shadowColor = shadowColor.cgColor
		layer.shadowOffset = shadowOffset
		layer.shadowOpacity = Float(shadowOpacity)
		layer.shadowRadius = shadowRadius
		
		contentView.layer.cornerRadius = cornerRadius
		contentView.layer.masksToBounds = true
	}
}
