//
//  PasswordStatusCircleView.swift
//  Movies
//
//  Created by Roman Zverik on 23.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class PasswordStatusCircleView: BaseView {
	
	private let stackView = UIStackView()
	private var statusViews = [UIView]()
	
	// MARK: - override func
	
	override func configure() {
		stackView.alignment = .center
		stackView.distribution = .equalSpacing
		
		(0...5).forEach { _ in
			stackView.addArrangedSubview(createStatusView())
		}
	}
	
	override func addSubviews() {
		addSubview(stackView)
	}
	
	override func makeConstraints() {
		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		stackView.arrangedSubviews.forEach { view in
			view.snp.makeConstraints { make in
				make.size.equalTo(20)
			}
		}
	}
	
	func pressedView(<#parameters#>) -> <#return type#> {
		<#function body#>
	}
	
	private func createStatusView() -> UIView {
		let view = UIView()
		view.bounds.size = CGSize(width: 20, height: 20)
		view.layer.cornerRadius = view.bounds.width/2
		view.backgroundColor = .gray
		view.layer.masksToBounds = false
		
		return view
	}
}
