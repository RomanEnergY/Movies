//
//  UIColor+Extention.swift
//  Movies
//
//  Created by Roman Zverik on 18.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

extension UIColor {

	// MARK: Public variables

	static func create(hex: String) -> UIColor {
		if ((hex.count) != 6) {
			return UIColor.gray
		}
		
		var rgbValue: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&rgbValue)
		
		let color = UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
		
		return color
	}
}

