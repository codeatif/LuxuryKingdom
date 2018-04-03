//
//  AngleView.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 19/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

@IBDesignable
class AngleView: UIView {
    
    @IBInspectable var fillColor: UIColor = UIColor.lightGray { didSet { setNeedsLayout() } }
    @IBInspectable var startPoint: CGPoint = CGPoint.zero { didSet { setNeedsLayout() } }
    @IBInspectable var stop1Point: CGPoint = CGPoint(x: 1, y: 0.2) { didSet { setNeedsLayout() } }
    @IBInspectable var stop2Point: CGPoint = CGPoint(x: 1, y: 1) { didSet { setNeedsLayout() } }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) { didSet { setNeedsLayout() } }
    
    private lazy var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()
    
    override func layoutSubviews() {
        shapeLayer.fillColor = fillColor.cgColor
       
        var points = [
            startPoint,
            stop1Point,
            stop2Point,
            endPoint
            ]
        
        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }
        
        let path = UIBezierPath()
        
        path.move(to: convert(relativePoint: points[0]))
        for point in points.dropFirst() {
            path.addLine(to: convert(relativePoint: point))
        }
        path.close()
        
        shapeLayer.path = path.cgPath
    }
    
    private func convert(relativePoint point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }
}
