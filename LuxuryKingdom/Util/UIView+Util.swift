//
//  UIView+Underline.swift
//  LendMePay
//
//  Created by Atif Imran on 20/02/18.
//  Copyright © 2018 Atif Imran. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func underline() {
        let border = CALayer()
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect.init(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5);
        border.borderWidth = CGFloat(1.0)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    struct Tag {
        static var key = "string_tag_key"
    }
    
    var stringTag:String? {//function created to set a string tag to a view -> used in other loans form
        get {
            return objc_getAssociatedObject( self, &Tag.key ) as? String
        }
        set {
            objc_setAssociatedObject( self, &Tag.key,  newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
