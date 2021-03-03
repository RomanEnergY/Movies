//
//  BeginningItemView.swift
//  Movies
//
//  Created by Roman Zverik on 20.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

final class BeginningItemView: BaseView {
	
	private let titleLabel = UILabel()
	private let stackView = UIStackView()
	private var stackViewBottomConstraint: Constraint?
	
	override func configure() {
		super.configure()
		
		titleLabel.numberOfLines = 0
		stackView.axis = .vertical
	}
	
	func set(titleParagraphView: TitleParagraphViewModel<WrappreString, WrappreArrayString>) {
		setTitle(titleParagraphView.title, textAlignment: titleParagraphView.textAlignment)
		setParagtash(titleParagraphView.paragraph, textAlignment: titleParagraphView.textAlignment)
		
		stackViewBottomConstraint?.update(inset: 10)
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(titleLabel)
		addSubview(stackView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(10)
			make.left.right.equalToSuperview()
		}
		
		stackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(5)
			make.left.right.equalToSuperview()
			stackViewBottomConstraint = make.bottom.equalToSuperview().constraint
		}
	}
	
	private func setTitle(_ fontTypeView: FontTypeViewModel<WrappreString>, textAlignment: NSTextAlignment) {
		titleLabel.font = fontTypeView.font
		titleLabel.textAlignment = textAlignment
		titleLabel.text = fontTypeView.data.text
	}
	
	private func setParagtash(_ fontTypeView: FontTypeViewModel<WrappreArrayString>, textAlignment: NSTextAlignment) {
		fontTypeView.data.array.forEach { paragraph in
			let label = UILabel()
			label.numberOfLines = 0
			label.font = fontTypeView.font
			label.textAlignment = textAlignment
			label.text = "\("🔹") \(paragraph)"
			stackView.addArrangedSubview(label)
		}
	}
}
