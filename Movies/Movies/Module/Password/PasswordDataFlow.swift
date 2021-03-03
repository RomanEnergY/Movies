//
//  PasswordDataFlow.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

enum Password {
	
	enum ViewState {
		case updatePasswordKey(count: Int)
		case keyNotInstalled
		case keyRepeat
		case errorInput
		case keyInstalled
		case updateKeyStatus(count: Int)
		case verificationKeySuccess
	}
}
