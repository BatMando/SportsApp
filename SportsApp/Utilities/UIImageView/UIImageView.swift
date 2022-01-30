//
//  UIImageView.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 30/01/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
extension UIImageView {

    @IBInspectable
    public var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }

        get {
            return self.layer.cornerRadius
        }
    }
    @IBInspectable
    public var isRounded: Bool
    {
        set {
            self.layer.cornerRadius = self.bounds.width / 2
            self.layer.masksToBounds = true
        }
        get {
            return false
        }
    }
}
