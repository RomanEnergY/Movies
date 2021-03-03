//
//  MainBaseView.swift
//  Movies
//
//  Created by Roman Zverik on 03.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation
import SnapKit

class MainBaseView: BaseView {
	
	var allBarsHeightConstraint: Constraint?
	
	override func layoutSubviews() {
		super.layoutSubviews()
		allBarsHeightConstraint?.update(inset: allBarsHeight)
	}
}
