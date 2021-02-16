//
//  BeginningPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol BeginningPresentationLogic {
	func presentNextView(response: Beginning.Response.NextView)
}

/// Отвечает за отображение данных модуля Onboarding
final class BeginningPresenter: BeginningPresentationLogic {

	// MARK: - Public variables
	weak var viewController: BeginningDisplayLogic?

	func presentNextView(response: Beginning.Response.NextView) {
		viewController?.display(viewState: .displayNextView(animated: response.animated))
	}
}
