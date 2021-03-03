//
//  BeginningPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol BeginningPresentationLogic {
	func showeBeginningState(data: BeginningDataProtocol)
	func presentNextView()
}

/// Отвечает за отображение данных модуля Onboarding
final class BeginningPresenter: BeginningPresentationLogic {

	// MARK: - Public variables
	weak var viewController: BeginningDisplayLogic?

	func showeBeginningState(data: BeginningDataProtocol) {
		viewController?.display(viewState: .beginningState(data: data))
	}
	
	func presentNextView() {
		viewController?.display(viewState: .nextView)
	}
}
