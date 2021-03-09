//
//  DevMenuDataFlow.swift
//  Movies
//
//  Created by Roman Zverik on 04.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

enum DevMenu {
	
	enum ViewState {
		case goNextModal(module: ModuleBuilder)
		case goNextPush(module: ModuleBuilder)
	}
}
