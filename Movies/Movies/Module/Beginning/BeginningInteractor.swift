//
//  BeginningInteractor.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol BeginningBusinessLogic {
	func showInitialState()
	func setBeginningShowedOnce()
}

/// Класс для описания бизнес-логики модуля Onboarding
final class BeginningInteractor: BeginningBusinessLogic {
	
	// MARK: - Private variables
	
	private let presenter: BeginningPresentationLogic
	private var appParameter: AppParameterProtocol
	
	// MARK: - Init
	
	init(
		presenter: BeginningPresentationLogic,
		appParameter: AppParameterProtocol = DI.container.resolve(AppParameterProtocol.self)
	) {
		self.presenter = presenter
		self.appParameter = appParameter
	}

	func showInitialState() {
		if appParameter.isBeginningViewShowedOnce == true {
			goNextView()
		}
	}

	func setBeginningShowedOnce() {
		appParameter.isBeginningViewShowedOnce = true
		goNextView()
	}
	
	// TODO: - переход на следующий экран
	private func goNextView() {
		presenter.presentNextView(response: Beginning.Response.NextView())
	}
}
