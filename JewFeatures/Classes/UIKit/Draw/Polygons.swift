import UIKit

@IBDesignable public class Triangle: UIView {
    
    @IBInspectable public var color: UIColor = .JEWBackground()
    @IBInspectable public var firstPointX: CGFloat = 0
    @IBInspectable public var firstPointY: CGFloat = 0
    @IBInspectable public var secondPointX: CGFloat = 0.0
    @IBInspectable public var secondPointY: CGFloat = 1
    @IBInspectable public var thirdPointX: CGFloat = 1
    @IBInspectable public var thirdPointY: CGFloat = 0

    override public func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: self.firstPointX * rect.width, y: self.firstPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.secondPointX * rect.width, y: self.secondPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.thirdPointX * rect.width, y: self.thirdPointY * rect.height))
        aPath.close()
        self.color.set()
        self.backgroundColor = .clear
        aPath.fill()
    }

}

@IBDesignable public class Rectangle: UIView {
    
    @IBInspectable public var color: UIColor = .JEWBackground()
    @IBInspectable public var firstPointX: CGFloat = 0
    @IBInspectable public var firstPointY: CGFloat = 0
    @IBInspectable public var secondPointX: CGFloat = 0
    @IBInspectable public var secondPointY: CGFloat = 1
    @IBInspectable public var thirdPointX: CGFloat = 1
    @IBInspectable public var thirdPointY: CGFloat = 1
    @IBInspectable public var forthPointX: CGFloat = 1
    @IBInspectable public var forthPointY: CGFloat = 0

    override public func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: self.firstPointX * rect.width, y: self.firstPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.secondPointX * rect.width, y: self.secondPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.thirdPointX * rect.width, y: self.thirdPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.forthPointX * rect.width, y: self.forthPointY * rect.height))
        aPath.close()
        self.color.set()
        self.backgroundColor = .clear
        aPath.fill()
    }

}

