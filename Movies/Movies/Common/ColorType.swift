//
//  ColorType.swift
//  Movies
//
//  Created by Roman Zverik on 18.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

enum ColorType: String {
	
	/// #FFFFFF = rgb(255,255,255)
	case white = "#FFFFFF"
	
	/// #000000 = rgb(0, 0, 0)
	case black = "#000000"
	
	/// #B8E5FF = rgb(184, 229, 255)
	case regular = "#B8E5FF"
	
	/// #76ACCD = rgb(118,172,205)
	case regularPressed = "#76ACCD"
	
	/// #001B43 = rgb(0, 27, 67)
	case border = "#001B43"
	
	/// #852323 = rgb(133,35,35)
	case shadowColorImageCinema = "#1B1412"
	
	/// #D7E1FA = rgb(215,225,250)
	case buttonNumberPressed = "#D7E1FA"
	
	/// #9AA2B4 = rgb(154,162,180)
	case buttonNumberDescriptionText = "#9AA2B4"
	
	/// #B8BDCA = rgb(184,189,202)
	case passwordStatusCircleDefault = "#B8BDCA"
	
	/// #98C47C = rgb(152,196,124)
	case passwordStatusCircleActive = "#98C47C"
	
	/// #F1938E = rgb(241,147,142)
	case passwordStatusCircleError = "#F1938E"
	
	/// #E7E5E5 = rgb(231,229,229)
	case gray = "#E7E5E5"
	
	/// #F0EFEF = rgb(240,239,239)
	case lightGray = "#F0EFEF"
	
	/// #E7E7E7 = rgb(231,231,231)
	case preloaderActive = "#E7E7E7"
	
	/// #F5F4F4 = rgb(245,244,244)
	case backgroundImage = "#F5F4F4"
}
