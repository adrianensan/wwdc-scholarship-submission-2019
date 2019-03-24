import SpriteKit

extension CGFloat {
    
    static func shortestAngle(from: CGFloat, to: CGFloat) -> CGFloat {
        var difference: CGFloat = to - from
        if abs(2 * .pi - abs(difference)) < abs(difference) {
            difference = abs(2 * .pi - abs(difference)) * -1 * difference.direction
        }
        return difference
    }

    var normalizedAngle: CGFloat {
        var angle: CGFloat = self.remainder(dividingBy: 2 * .pi)
        if angle < 0 { angle += 2 * .pi }
        return angle
    }
    
    var direction: CGFloat {
        return self >= 0 ? 1 : -1
    }
    
    func inDirectionOf(rotation: CGFloat) -> CGPoint {
        return CGPoint(x: self * cos(rotation), y: self * sin(rotation))
    }
}

extension CGSize {
    
    static func +(left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width + right, height: left.height + right)
    }
    
    static func /(left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width / right, height: left.height / right)
    }
    
    var middle: CGPoint {
        return CGPoint(x: 0.5 * width, y: 0.5 * height)
    }
    
    var offset: CGPoint {
        return CGPoint(x: -0.5 * width, y: -0.5 * height)
    }
    
    var ceneteredRect: CGRect {
        return CGRect(origin: offset, size: self)
    }
    
    var diagonal: CGFloat {
        return sqrt(width * width + height * height)
    }
}

extension CGRect {
    
    var middle: CGPoint {
        return CGPoint(x: origin.x + 0.5 * width, y: origin.y + 0.5 * height)
    }
    
    func originOffsetFromCenter(offset: CGSize) -> CGPoint {
        return CGPoint(x: origin.x + 0.5 * (width - offset.width), y: origin.y + 0.5 * (height - offset.height))
    }
}

extension CGPoint {
    
    static func +=(left: inout CGPoint, right: CGPoint) {
        left = left + right
    }
    
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func +(left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x + right, y: left.y + right)
    }
    
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func *(left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
    
    var distance: CGFloat {
        return sqrt(x * x + y * y)
    }
}

extension SKNode {
    func run(_ action: SKAction, timingMode: SKActionTimingMode) {
        action.timingMode = timingMode
        run(action)
    }
}
