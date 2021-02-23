//
//  PasswordInteractor.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol PasswordBusinessLogic {
	func showInitialState()
	func keyPressed(key: PasswordView.Key)
}

final class PasswordInteractor: PasswordBusinessLogic {
		
	private let presenter: PasswordPresentationLogic
	private var appParameter: AppParameterProtocol
	private var passwordKeyProvider: PasswordKeyProviderProtocol
	private let keyCount: Int
	
	init(
		presenter: PasswordPresentationLogic,
		keyCount: Int,
		appParameter: AppParameterProtocol = DI.container.resolve(AppParameterProtocol.self),
		passwordKeyProvider: PasswordKeyProviderProtocol = DI.container.resolve(PasswordKeyProviderProtocol.self)
	) {
		self.presenter = presenter
		self.keyCount = keyCount
		self.appParameter = appParameter
		self.passwordKeyProvider = passwordKeyProvider
		self.passwordKeyProvider.setFilled(count: self.keyCount)
		self.passwordKeyProvider.delegate = self
	}
	
	func showInitialState() {
		if let password = appParameter.passwordNumberKey,
		   password.count == keyCount,
		   appParameter.isPasswordNumberKeyInstalled == true {
			verificationEntrance(password: password)
		}
		else {
			verificationSet()
		}
		
		presenter.updateKey(count: keyCount)
	}
	
	func keyPressed(key: PasswordView.Key) {
		passwordKeyProvider.addKey(key: key)
	}
	
	private func verificationSet() {
		self.passwordKeyProvider.verificationProvider = VerificationSetProvider()
		presenter.keyNotInstalled()
	}
	
	private func verificationEntrance(password: String) {
		self.passwordKeyProvider.verificationProvider = VerificationEntranceProvider(password: password)
		presenter.keyInstalled()
	}
}

extension PasswordInteractor: PasswordKeyProviderDelegate {
	
	func updateKeyStatus(count: Int) {
		presenter.updateKeyStatus(count: passwordKeyProvider.count)
	}
	
	func filledFirstKey() {
		presenter.keyRepeat()
		presenter.updateKeyStatus(count: passwordKeyProvider.count)
	}
	
	func resetKey() {
		presenter.errorInput()
		presenter.keyNotInstalled()
	}
	
	func errorInput() {
		presenter.errorInput()
	}
	
	func verificationKeySuccess(password: String) {
		appParameter.passwordNumberKey = password
		appParameter.isPasswordNumberKeyInstalled = true
		
		presenter.verificationKeySuccess()
	}
}
