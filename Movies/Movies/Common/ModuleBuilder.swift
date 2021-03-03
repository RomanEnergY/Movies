//
//  ModuleBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol ModuleBuilder: class {
	init()
	func build() -> BaseViewController
}
