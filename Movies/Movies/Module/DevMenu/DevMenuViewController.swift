//
//  DevMenuViewController.swift
//  Movies
//
//  Created by Roman Zverik on 04.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol DevMenuViewDisplayLogic: class {
	
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
	
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		logger.log(.warning, "Вызов DevMenu из DevMenu запрещен! 😇")
	}
	
	@objc private func closeButtonPressed() {
		dismiss(animated: true)
	}
}

extension DevMenuViewController: DevMenuViewDelegate {
	
}

extension DevMenuViewController: DevMenuViewDisplayLogic {
	
}
