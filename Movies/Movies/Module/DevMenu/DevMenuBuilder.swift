//
//  DevMenuBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 04.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class DevMenuBuilder: ModuleBuilder {
	
	func build() -> BaseViewController {
		
		let presenter = DevMenuPresenter()
		let interactor = DevMenuInteractor(presenter: presenter)
		let controller = DevMenuViewController(interactor: interactor)
		
		presenter.viewController = controller
		
		return controller
	}
}
