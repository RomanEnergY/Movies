//
//  String+Extention.swift
//  MoviesMVVM
//
//  Created by 1234 on 25.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
            let fontAttributes = [NSAttributedString.Key.font: font]
            let size = (self as NSString).size(withAttributes: fontAttributes)
            return size.width
        }

        func heightOfString(usingFont font: UIFont) -> CGFloat {
            let fontAttributes = [NSAttributedString.Key.font: font]
            let size = (self as NSString).size(withAttributes: fontAttributes)
            return size.height
        }

        func sizeOfString(usingFont font: UIFont) -> CGSize {
            let fontAttributes = [NSAttributedString.Key.font: font]
            return (self as NSString).size(withAttributes: fontAttributes)
        }
}
