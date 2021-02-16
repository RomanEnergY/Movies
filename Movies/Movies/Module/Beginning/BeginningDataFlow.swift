//
//  BeginningDataFlow.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

enum Beginning {
	
	enum Response {
		struct NextView {
			let animated: Bool = true
		}
	}
	
	enum ViewControllerState {
		// TODO: Определиться о названии следующего экран
		case displayNextView(animated: Bool)
	}
}
