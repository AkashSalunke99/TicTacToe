import Foundation
import UIKit

class Shapes {
    static func drawCross(in bounds: CGRect) -> CAShapeLayer {
        let shapeLayer = shapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        let path = UIBezierPath(rect: CGRectMake(0, 0, bounds.width, bounds.height))
        path.move(to: CGPointMake(30, 30))
        path.addLine(to: CGPointMake(bounds.width - 30, bounds.height - 30))
        path.move(to: CGPointMake(bounds.width - 30, 30))
        path.addLine(to: CGPointMake(30, bounds.height - 30))
        shapeLayer.path = path.cgPath
        startAnimation(shapeLayer)
        return shapeLayer
    }
    
    static func drawCircle(in bounds: CGRect) -> CAShapeLayer {
        let shapeLayer = shapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        let path  = UIBezierPath(ovalIn: CGRectMake(20, 20, bounds.width - 40, bounds.height - 40))
        shapeLayer.path = path.cgPath
        startAnimation(shapeLayer)
        return shapeLayer
    }
    
    static func drawLine(in bounds: CGRect, startPoint: CGPoint, endPoint: CGPoint) -> CAShapeLayer {
        let shapeLayer = shapeLayer()
        let path = UIBezierPath(rect: bounds)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        shapeLayer.path = path.cgPath
        startAnimation(shapeLayer)
        return shapeLayer
    }
    
    static func shapeLayer() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.borderWidth = 0
        return shapeLayer
    }
    
    private static func startAnimation(_ shapeLayer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        shapeLayer.add(animation, forKey: "strokeEnd")
    }
}
