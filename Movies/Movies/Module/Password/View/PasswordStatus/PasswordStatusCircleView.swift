//
//  PasswordStatusCircleView.swift
//  Movies
//
//  Created by Roman Zverik on 23.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class PasswordStatusCircleView: BaseView {
	
	private let colorViewDefault: UIColor = Dev.Color.create(colorType: .passwordStatusCircleDefault)
	private let colorViewActive: UIColor = Dev.Color.create(colorType: .passwordStatusCircleActive)
	private let colorViewError: UIColor = Dev.Color.create(colorType: .passwordStatusCircleError)
	private let stackView = UIStackView()
	
	// MARK: - override func
	
	override func configure() {
		stackView.alignment = .center
		stackView.distribution = .equalSpacing
	}
	
	override func addSubviews() {
		addSubview(stackView)
	}
	
	override func makeConstraints() {
		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func updatePasswordKey(count: Int) {
		(0...count - 1).forEach { _ in
			stackView.addArrangedSubview(createStatusView())
		}
		
		stackView.arrangedSubviews.forEach { view in
			view.snp.makeConstraints { make in
				make.size.equalTo(20)
			}
		}
	}
	
	func updateColorView(count: Int) {
		var count = count
		
		stackView.arrangedSubviews.forEach { [weak self] view in
			guard let self = self else { return }
			if count > 0 {
				view.backgroundColor = self.colorViewActive
				count -= 1
			}
			else {
				view.backgroundColor = self.colorViewDefault
			}
		}
	}
	
	func errorInput() {
		stackView.arrangedSubviews.forEach { [weak self] view in
			guard let self = self else { return }
			view.backgroundColor = self.colorViewError
		}
		
		DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
			DispatchQueue.main.async { [weak self] in
				guard let self = self else { return }
				self.stackView.arrangedSubviews.forEach { view in
					view.backgroundColor = self.colorViewDefault
				}
			}
		}
	}
	
	private func createStatusView() -> UIView {
		let view = UIView()
		view.bounds.size = CGSize(width: 20, height: 20)
		view.layer.cornerRadius = view.bounds.width/2
		view.backgroundColor = colorViewDefault
		view.layer.masksToBounds = false
		
		return view
	}
}
