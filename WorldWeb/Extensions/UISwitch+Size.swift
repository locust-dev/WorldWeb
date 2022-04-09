//
//  UISwitch+Size.swift
//  WorldWeb
//
//  Created by Ilya Turin on 10.04.2022.
//

import UIKit

extension UISwitch {

    func setSize(width: CGFloat) {
        
        let standardHeight: CGFloat = width * 0.6078
        let heightRatio = standardHeight / 31
        let widthRatio = width / 51
        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
