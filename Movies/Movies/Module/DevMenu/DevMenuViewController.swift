//
//  DevMenuViewController.swift
//  Movies
//
//  Created by Roman Zverik on 04.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol DevMenuViewDisplayLogic: class {
	func display(viewState: DevMenu.ViewState)
}

final class DevMenuViewController: BaseViewController {
	
	private let customView = DevMenuView()
	private let interactor: DevMenuBusinessLogic
	
	init(
		interactor: DevMenuBusinessLogic
	) {
		self.interactor = interactor
		super.init()
		
		title = "DevMenu"
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
			
		view = customView
		customView.delegate = self
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonPressed))
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	@objc private func closeButtonPressed() {
		dismiss(animated: true)
	}
}

extension DevMenuViewController: DevMenuViewDelegate {
	func goNextModal(module: ModuleBuilder) {
		display(viewState: .goNextModal(module: module))
	}
	
	func goNextPush(module: ModuleBuilder) {
		display(viewState: .goNextPush(module: module))
	}
}

extension DevMenuViewController: DevMenuViewDisplayLogic {
	func display(viewState: DevMenu.ViewState) {
		switch viewState {
			case .goNextModal(let module):
				appNavigator.go(module: module, mode: .modal(animated: true))
			case .goNextPush(let module):
				appNavigator.go(module: module, mode: .push(animated: true))
		}
	}
}
