//
//  UIFont+Extensions.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 23/03/23.
//

import UIKit

extension UIFont {
    static func preferredFont(forTextStyle style: UIFont.TextStyle, weight: Weight) -> UIFont {
        let size = UIFont.preferredFont(forTextStyle: style).fontDescriptor.pointSize
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        return UIFontMetrics(forTextStyle: style).scaledFont(for: font)
    }
}
