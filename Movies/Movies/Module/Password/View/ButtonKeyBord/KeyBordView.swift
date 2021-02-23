//
//  KeyBordView.swift
//  Movies
//
//  Created by Roman Zverik on 23.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol KeyBordViewDelegate: class {
	func controlPressed(devType: ButtonNumber.DevType)
}

final class KeyBordView: BaseView {
	
	private let heightButton = UIScreen.main.bounds.height/10
	private var keyButtonBord = [[ButtonNumber.DevType]]()
	private let stackView = UIStackView()
	
	weak var delegate: KeyBordViewDelegate?
	
	override func configure() {
		
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		
		let keyButtonBord: [[ButtonNumber.DevType]] = [
			[.one, .two, .three],
			[.four, .five, .six],
			[.seven, .eight, .nine],
			[.stub, .ziro, .remove]
		]
		
		keyButtonBord.forEach { [weak self] devTypes in
			let stackHorizontal = UIStackView()
			stackHorizontal.axis = .horizontal
			stackHorizontal.distribution = .equalSpacing
			
			devTypes.forEach { devType in
				let button = ButtonNumber(devType: devType)
				button.delegate = self
				stackHorizontal.addArrangedSubview(button)
			}
			
			stackView.addArrangedSubview(stackHorizontal)
		}
	}
	
	override func addSubviews() {
		addSubview(stackView)
	}
	
	override func makeConstraints() {
		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		stackView.arrangedSubviews.forEach { [weak self] views in
			guard let stackHorizontal = views as? UIStackView else { return }
			stackHorizontal.arrangedSubviews.forEach { view in
				view.snp.makeConstraints { make in
					guard let self = self else { return }
					make.size.equalTo(self.heightButton)
				}
			}
		}
	}
}

extension KeyBordView: ControlPressedDelegate {
	func controlPressed(devType: ButtonNumber.DevType) {
		delegate?.controlPressed(devType: devType)
	}
}
