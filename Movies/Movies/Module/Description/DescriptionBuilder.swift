//
//  DescriptionBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class DescriptionBuilder: ModuleBuilder {
	
	required init() { }
	
	func build() -> BaseViewController {
		let presenter = DescriptionPresenter()
		let interactor = DescriptionIterator(presenter: presenter)
		let controller = DescriptionViewController(interactor: interactor)

		presenter.viewController = controller
		
		return controller
	}
}
