//
//  UILabel+Ext.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 18/02/23.
//

import UIKit

extension UILabel {
    func applyStyle(stringText: String, fontName: Font, size: CGFloat, lines: Int) {
        text = stringText
        font = UIFont(name: fontName.rawValue, size: size)
        numberOfLines = lines
    }
}
