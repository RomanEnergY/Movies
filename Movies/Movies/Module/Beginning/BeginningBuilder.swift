//
//  BeginningBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class BeginningBuilder: ModuleBuilder {
	required init() { }

	func build() -> BaseViewController {
		let presenter = BeginningPresenter()
		let interactor = BeginningInteractor(presenter: presenter)
		let controller = BeginningViewController(interactor: interactor)

		presenter.viewController = controller
		return controller
	}
}
