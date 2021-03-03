//
//  BeginningView.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol BeginningViewDelegate: class {
	func continueButtonPressed()
}

final class BeginningView: BaseView {
	
	// MARK: private var
	
	private let bacgraundImage = UIImageView()
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	private let shadowRoundView = ShadowRoundView()
	private let titleLabel = UILabel()
	private let stackView = UIStackView()
	private let continueButton = Dev.Button.create(devType: .regular)
	private var allBarsHeightConstraint: Constraint?
	
	weak var delegate: BeginningViewDelegate?
	
	override func configure() {
		super.configure()
		
		backgroundColor = Dev.Color.create(colorType: .white)
		
		bacgraundImage.image = UIImage(named: "kino")
		bacgraundImage.alpha = 0.05
		
		let imageView = UIImageView(image: UIImage(named: "Cinema"))
		shadowRoundView.wrap(view: imageView)
		shadowRoundView.shadowColor = Dev.Color.create(colorType: .shadowColorImageCinema)
		
		titleLabel.font = UIFont.boldSystemFont(ofSize: 21.0)
		titleLabel.textAlignment = .center
		titleLabel.numberOfLines = 0
		
		stackView.axis = .vertical
		
		continueButton.setTitle("Send", for: .normal)
		continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(bacgraundImage)
		addSubview(scrollView)
		
		scrollView.addSubview(contentView)
		contentView.addSubview(shadowRoundView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(stackView)
		contentView.addSubview(continueButton)
	}
	
	override func makeConstraints() {
		bacgraundImage.snp.makeConstraints { (make) in
			allBarsHeightConstraint = make.top.equalToSuperview().constraint
			make.left.right.bottom.equalToSuperview()
		}
		
		scrollView.snp.makeConstraints { (make) in
			make.edges.equalTo(bacgraundImage)
		}
		
		contentView.snp.makeConstraints { (make) in
			make.edges.centerX.equalToSuperview()
		}
		
		shadowRoundView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(20)
			make.left.right.equalToSuperview().inset(20)
			make.height.equalTo(100)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(shadowRoundView.snp.bottom).offset(40)
			make.left.right.equalToSuperview().inset(20)
		}
		
		stackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.left.right.equalToSuperview().inset(20)
		}
		
		continueButton.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(10)
			make.left.right.equalToSuperview().inset(20)
			make.bottom.equalToSuperview().inset(20)
			make.height.equalTo(40)
		}
		
		super.makeConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		allBarsHeightConstraint?.update(inset: allBarsHeight)
	}
	
	func update(data: BeginningDataProtocol) {
		titleLabel.text = data.title
		
		for i in 0 ... data.paragraphs.count - 1 {
			var titleFont: UIFont = UIFont.systemFont(ofSize: 16)
			let paragraphsFont: UIFont = UIFont.italicSystemFont(ofSize: 14)
			var textAlignment: NSTextAlignment = .natural
			
			if i == data.paragraphs.count - 1 {
				titleFont = UIFont.italicSystemFont(ofSize: 12)
				textAlignment = .right
			}
			
			let titleFontView = FontTypeViewModel(
				data: WrappreString(text: data.paragraphs[i].title),
				font: titleFont)
			
			let paragraphsFontView = FontTypeViewModel(
				data: WrappreArrayString(array: data.paragraphs[i].paragraph),
				font: paragraphsFont)
			
			let titleParagraphFontView = TitleParagraphViewModel(title: titleFontView,
																 paragraph: paragraphsFontView,
																 textAlignment: textAlignment)
			
			let beginningItemView = BeginningItemView()

			beginningItemView.set(titleParagraphView: titleParagraphFontView)
			stackView.addArrangedSubview(beginningItemView)
		}
	}
	
	@objc private func continueButtonPressed() {
		delegate?.continueButtonPressed()
	}
}
