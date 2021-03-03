//
//  PasswordBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

import Foundation

final class PasswordBuilder: ModuleBuilder {
	
	struct Config {
		let keyCount: Int
	}
	
	private let config: Config
	
	init(config: Config) {
		self.config = config
	}
	
	required init() {
		config = Config(keyCount: 5)
	}

	func build() -> BaseViewController {
		let presenter = PasswordPresenter()
		let interactor = PasswordInteractor(presenter: presenter, keyCount: config.keyCount)
		let controller = PasswordViewController(interactor: interactor)

		presenter.viewController = controller
		return controller
	}
}
