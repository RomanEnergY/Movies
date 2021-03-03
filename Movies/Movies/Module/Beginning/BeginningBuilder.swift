//
//  BeginningBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class BeginningBuilder: ModuleBuilder {
	
	
	struct Config {
		let data: BeginningDataProtocol
	}
	
	private let config: Config
	
	required init() {
		self.config = Config(data: BeginningData())
	}
	
	init(config: Config) {
		self.config = config
	}

	func build() -> BaseViewController {
		let presenter = BeginningPresenter()
		let interactor = BeginningInteractor(presenter: presenter)
		let controller = BeginningViewController(data: config.data, interactor: interactor)

		presenter.viewController = controller
		return controller
	}
}
