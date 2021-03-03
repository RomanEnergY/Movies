//
//  BeginningInteractor.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol BeginningBusinessLogic {
	func initialState(data: BeginningDataProtocol)
	func setBeginningShowedOnce()
}

/// Класс для описания бизнес-логики модуля Onboarding
final class BeginningInteractor: BeginningBusinessLogic {
	
	// MARK: - Private variables
	
	private let presenter: BeginningPresentationLogic
	weak var appParameter: AppParameterProtocol?
	
	// MARK: - Init
	
	init(
		presenter: BeginningPresentationLogic
//		appParameter: AppParameterProtocol = DI.container.resolve(AppParameterProtocol.self)
	) {
		self.presenter = presenter
//		self.appParameter = appParameter
	}

	func initialState(data: BeginningDataProtocol) {
		if appParameter?.isBeginningViewShowedOnce == true {
			goNextView()
		}
		else {
			presenter.showeBeginningState(data: data)
		}
	}

	func setBeginningShowedOnce() {
		appParameter?.isBeginningViewShowedOnce = true
		goNextView()
	}
	
	private func goNextView() {
		presenter.presentNextView()
	}
}
