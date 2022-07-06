//
//  CALayer+.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

extension CALayer {
    
    func applyShadow(color: UIColor = .black,
                     alpha: Float = 0.5,
                     x: CGFloat = 0,
                     y: CGFloat = 2,
                     blur: CGFloat = 4) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
