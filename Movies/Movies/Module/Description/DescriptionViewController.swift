//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DescriptionDisplayLogic: class {
	func display(viewState: Description.ViewControllerState)
}

final class DescriptionViewController: BaseViewController {
	
	// MARK: - private variable
	
	private let interactor: DescriptionBusinessLogic
	
	init(interactor: DescriptionBusinessLogic) {
		self.interactor = interactor
		super.init()
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
}

extension DescriptionViewController: DescriptionDisplayLogic {
	func display(viewState: Description.ViewControllerState) {
		
	}
}
