//
//  MockAssemblyBuilder.swift
//  MoviesMVVMTests
//
//  Created by 1234 on 22.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation
import UIKit
@testable import MoviesMVVM

class MockAssemblyBuilder: AssemblyBuilder {
    override func createModuleMain(router: RouterProtocol) -> UIViewController {
        let mainModel = MainModel()
        let viewModel = MockMainViewModel(router: router, mainModel: mainModel)
        let view = MainView()
        
        view.viewModel = viewModel
        
        return view
    }
}
