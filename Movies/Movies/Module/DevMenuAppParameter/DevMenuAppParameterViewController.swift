//
//  DevMenuAppParameterViewController.swift
//  Movies
//
//  Created by Roman Zverik on 08.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol DevMenuAppParameterDisplayLogic: class {
	
}

final class DevMenuAppParameterViewController: BaseViewController {
	
	// MARK: - private variables
	
	private let interactor: DevMenuAppParameterBusinessLogic
	private let customView = DevMenuAppParameterView()
	
	// MARK: - Initializers
	
	init(
		interactor: DevMenuAppParameterBusinessLogic
	) {
		self.interactor = interactor
		super.init()
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view = customView
		customView.delegate = self
		
	}
}

extension DevMenuAppParameterViewController : DevMenuAppParameterViewDelegate {
	
}

extension DevMenuAppParameterViewController: DevMenuAppParameterDisplayLogic {
	
}
