//
//  AngleImageView.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 19/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

@IBDesignable
class AngleImageView: UIImageView {

    override func setNeedsLayout() {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: self.frame.origin.x, y: self.frame.size.height/4))//start here
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.origin.y))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.origin.x, y: self.frame.size.height))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
        self.layer.masksToBounds = true
    }
}

