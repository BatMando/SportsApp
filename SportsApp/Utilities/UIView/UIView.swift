//
//  UIView.swift
//  SportsApp
//
//  Created by admin on 1/30/22.
//  Copyright © 2022 admin. All rights reserved.
//
import UIKit
extension UIView {
    @IBInspectable var shadow: Bool {
           get {
               return layer.shadowOpacity > 0.0
           }
           set {
               if newValue == true {
                   self.addShadow()
               }
           }
       }

       @IBInspectable var cornerRadius: CGFloat {
           get {
               return self.layer.cornerRadius
           }
           set {
               self.layer.cornerRadius = newValue

               // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
               if shadow == false {
                   self.layer.masksToBounds = true
               }
           }
       }


//       func addShadow(shadowColor: CGColor = UIColor.white.cgColor,
//                  shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
//                  shadowOpacity: Float = 0.4,
//                  shadowRadius: CGFloat = 3.0) {
//           layer.shadowColor = shadowColor
//           layer.shadowOffset = shadowOffset
//           layer.shadowOpacity = shadowOpacity
//           layer.shadowRadius = shadowRadius
//       }
    
    func addShadow(shadowColor: CGColor = UIColor.white.cgColor,
                     shadowOffset: CGSize = CGSize(width: 2.0, height: 2.0),
                     shadowOpacity: Float = 0.5,
                     shadowRadius: CGFloat = 10.0) {
              layer.shadowColor = shadowColor
              layer.shadowOffset = shadowOffset
              layer.shadowOpacity = shadowOpacity
              layer.shadowRadius = shadowRadius
          }
}
