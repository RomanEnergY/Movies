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
	private let appParameter: AppParameterProtocol
	private var isAppPreviousVisit: Bool {
		get {
			appParameter.get(key: AppParameterKey.isBeginningViewShowedOnce, type: Bool.self) == true
		}
		set {
			appParameter.set(key: AppParameterKey.isBeginningViewShowedOnce, value: newValue)
		}
	}
	
	// MARK: - Init
	
	init(
		presenter: BeginningPresentationLogic,
		appParameter: AppParameterProtocol = DI.container.resolve(AppParameterProtocol.self)
	) {
		self.presenter = presenter
		self.appParameter = appParameter
	}

	func showInitialState() {
		if isAppPreviousVisit {
			goNextView()
		}
	}

	func setBeginningShowedOnce() {
		isAppPreviousVisit = true
		goNextView()
	}
	
	// TODO: - переход на следующий экран
	private func goNextView() {
		presenter.presentNextView(response: Beginning.Response.NextView())
	}
}
