//
//  PasswordViewController.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol PasswordDisplayLogic: class {
	func display(viewState: Password.ViewState)
}

final class PasswordViewController: BaseViewController {
	
	private let customView = PasswordView()
	private let interactor: PasswordBusinessLogic
	
	init(interactor: PasswordBusinessLogic) {
		self.interactor = interactor
		super.init()
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		view = customView
		customView.delegate = self
		title = "Movies GO"
		interactor.showInitialState()
	}
}

extension PasswordViewController: PasswordDisplayLogic {
	func display(viewState: Password.ViewState) {
		switch viewState {
			case .updatePasswordKey(let count):
				customView.updatePasswordKey(count: count)
			case .keyNotInstalled:
				customView.keyNotInstalled()
			case .keyRepeat:
				customView.keyRepeat()
			case .errorInput:
				customView.errorInput()
			case .keyInstalled:
				customView.keyInstalled()
			case .updateKeyStatus(let count):
				customView.updatePasswordKeyStatusView(count: count)
			case .verificationKeySuccess:
				appNavigator.go(module: MovieFeedBuilder(), mode: .replaceAll(animated: true))
		}
	}
}

extension PasswordViewController: PasswordViewDelegate {
	func keyPressed(key: PasswordView.Key) {
		interactor.keyPressed(key: key)
	}
}
