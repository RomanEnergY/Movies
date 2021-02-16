//
//  DescriptionIterator.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DescriptionBusinessLogic {
	
}

final class DescriptionIterator: DescriptionBusinessLogic {
	
	// MARK: - private variable
	
	private let presenter: DescriptionPresentationLogic
	
	init(presenter: DescriptionPresentationLogic) {
		self.presenter = presenter
	}
}
