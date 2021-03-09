//
//  DevMenuPresentNextView.swift
//  Movies
//
//  Created by Roman Zverik on 07.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol DevMenuGoNextModuleDelegate: class {
	func goNextModal(module: ModuleBuilder)
	func goNextPush(module: ModuleBuilder)
}

final class DevMenuPresentNextView: BaseView {
	
	// MARK: - Types
	
	enum PresentType {
		case modal
		case push
	}
	
	// MARK: - private variables
	
	private let titleLabel = UILabel()
	private let presentNextLabel = UILabel()
	
	// MARK: - public variables
	weak var delegate: DevMenuGoNextModuleDelegate?
	var goNextModule: ModuleBuilder?
	var type: PresentType = .push {
		didSet {
			switch type {
				case .modal:
					presentNextLabel.text = "⬆️"
				case .push:
					presentNextLabel.text = "➡️"
			}
		}
	}
	
	// MARK: - lifecycle
	
	override func configure() {
		super.configure()
		
		type = .push
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(titleLabel)
		addSubview(presentNextLabel)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(10)
			make.left.right.equalToSuperview().inset(10)
			make.bottom.equalToSuperview().inset(10)
		}
		
		presentNextLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.right.equalToSuperview().inset(10)
		}
	}
	
	// MARK: - public methods
	
	func update(text: String) {
		titleLabel.text = text
	}
	
	func action() {
		guard let goNextModule = goNextModule else {
			logger.log(.error, "Не установлен модуль для перехода")
			return
		}
		
		switch type {
			case .modal:
				delegate?.goNextModal(module: goNextModule)
			case .push:
				delegate?.goNextPush(module: goNextModule)
		}
	}
}
