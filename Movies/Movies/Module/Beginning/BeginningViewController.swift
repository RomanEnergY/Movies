//
//  BeginningViewController.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

// MARK: - OnboardingDisplayLogic

protocol BeginningDisplayLogic: class {
	func display(viewState: Beginning.ViewControllerState)
}

// MARK: - OnboardingViewController

final class BeginningViewController: BaseViewController {

	// MARK: Private variables
	
	private let interactor: BeginningBusinessLogic
	private var customView = BeginningView()
	
	// MARK: Init

	init(interactor: BeginningBusinessLogic) {
		self.interactor = interactor
		super.init()
		isHiddenNavigationBar = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view = customView
		customView.delegate = self
		interactor.showInitialState()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
}

extension BeginningViewController: BeginningViewDelegate {
	func continueButtonPressed() {
		interactor.setBeginningShowedOnce()
	}
}

extension BeginningViewController: BeginningDisplayLogic {
	func display(viewState: Beginning.ViewControllerState) {
		switch viewState {
			case .displayNextView:
				appNavigator.go(module: PasswordBuilder(), mode: .replaceAll(animated: true))
		}
	}
}
