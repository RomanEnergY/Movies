//
//  MockAssemblyBuilder.swift
//  MoviesTests
//
//  Created by Roman Zverik on 22.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation
import UIKit
@testable import Movies

class MockAssemblyBuilder: AssemblyBuilder {
	override func createModuleMain(router: RouterProtocol) -> UIViewController {
		let mainModel = MainModel()
		let viewModel = MockMainViewModel(router: router, mainModel: mainModel)
		let view = MainView()
		
		view.viewModel = viewModel
		
		return view
	}
}
