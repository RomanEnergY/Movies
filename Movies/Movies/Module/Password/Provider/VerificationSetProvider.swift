//
//  VerificationSetProvider.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class VerificationSetProvider: VerificationProviderProtocol {
	
	// MAKR: - private variable
	
	private var firstKey = ""
	private var secondKey = ""
	private var isFilledFirstKey = true
	private var countFilled = 5
	var delegate: PasswordKeyProviderDelegate?
	
	// MAKR: - public variable
	
	var count: Int {
		if isFilledFirstKey {
			return firstKey.count
		}
		else {
			return secondKey.count
		}
	}
	
	// MAKR: - public functions
	
	func setFilled(count: Int) {
		countFilled = count
	}
	
	func addKey(key: PasswordView.Key) {
		if isFilledFirstKey {
			update(password: &firstKey, key: key)
			delegate?.updateKeyStatus(count: count)
			if firstKey.count == countFilled {
				isFilledFirstKey = false
				delegate?.filledFirstKey()
			}
		}
		else {
			update(password: &secondKey, key: key)
			delegate?.updateKeyStatus(count: count)
			if secondKey.count == countFilled {
				if firstKey == secondKey {
					delegate?.verificationKeySuccess(password: secondKey)
				}
				else {
					firstKey = ""
					secondKey = ""
					isFilledFirstKey = true
					delegate?.resetKey()
				}
			}
		}
	}
	
	private func update(password: inout String, key: PasswordView.Key) {
		if key == .remove {
			if !password.isEmpty {
				password.removeLast()
			}
		}
		else {
			password += key.rawValue
		}
		
	}
}
