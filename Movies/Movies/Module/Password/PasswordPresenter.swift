//
//  PasswordPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol PasswordPresentationLogic {
	func updateKey(count: Int)
	func keyNotInstalled()
	func keyRepeat()
	func errorInput()
	func keyInstalled()
	func updateKeyStatus(count: Int)
	func verificationKeySuccess()
}

final class PasswordPresenter: PasswordPresentationLogic {
	
	weak var viewController: PasswordDisplayLogic?
	
	func updateKey(count: Int) {
		viewController?.display(viewState: .updatePasswordKey(count: count))
	}
	
	func keyNotInstalled() {
		viewController?.display(viewState: .keyNotInstalled)
	}
	
	func keyRepeat() {
		viewController?.display(viewState: .keyRepeat)
	}
	
	func errorInput() {
		viewController?.display(viewState: .errorInput)
	}
	
	func keyInstalled() {
		viewController?.display(viewState: .keyInstalled)
	}
	
	func updateKeyStatus(count: Int) {
		viewController?.display(viewState: .updateKeyStatus(count: count))
	}
	
	func verificationKeySuccess() {
		viewController?.display(viewState: .verificationKeySuccess)

	}
}
