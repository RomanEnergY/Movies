//
//  BaseView.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation
import UIKit

/// Базовый класс вью
class BaseView: UIView {
	
	public override init(frame: CGRect = CGRect.zero) {
		super.init(frame: frame)
		addSubviews()
		makeConstraints()
		configure()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override open func layoutSubviews() {
		super.layoutSubviews()
	}
	
	open func configure() { }
	
	open func addSubviews() { }
	
	open func makeConstraints() { }
}
