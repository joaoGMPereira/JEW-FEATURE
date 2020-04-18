import UIKit


public enum JEWLineTipe {
    case diagonal
    case line(axysXFirst: CGFloat, axysYFirst: CGFloat, axysXSecond: CGFloat, axysYSecond: CGFloat)
}

public class JEWLine: UIView {
    public var lineWidth: CGFloat = 1
    public var flip: Bool = false
    public var color: UIColor = UIColor.black
    public var type: JEWLineTipe = .diagonal
    
    override public func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.lineWidth = self.lineWidth
        switch type {
        case .diagonal:
            if self.flip {
                aPath.move(to: CGPoint(x: 0, y: 0))
                aPath.addLine(to: CGPoint(x: rect.width, y: rect.height))
            } else {
                aPath.move(to: CGPoint(x: 0, y: rect.height))
                aPath.addLine(to: CGPoint(x: rect.width, y: 0))
            }
            break
        case .line(axysXFirst: let axysXFirst, axysYFirst: let axysYFirst, axysXSecond: let axysXSecond, axysYSecond: let axysYSecond):
            aPath.move(to: CGPoint(x: axysXFirst*rect.width, y: axysYFirst*rect.height))
            aPath.addLine(to: CGPoint(x: axysXSecond*rect.width, y: axysYSecond*rect.height))
            break
        }
        aPath.close()
        self.color.set()
        aPath.stroke()
    }
    
}
