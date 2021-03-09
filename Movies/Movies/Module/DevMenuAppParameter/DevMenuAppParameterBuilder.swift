//
//  DevMenuAppParameterBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 08.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class DevMenuAppParameterBuilder: ModuleBuilder {
	
	func build() -> BaseViewController {
		
		let presenter = DevMenuAppParameterPresenter()
		let interactor = DevMenuAppParameterInteractor(presenter: presenter)
		let controller = DevMenuAppParameterViewController(interactor: interactor)
		
		presenter.viewController = controller
		return controller
	}
}
