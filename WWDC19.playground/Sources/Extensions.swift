import SpriteKit

extension SKNode {

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
}

extension CGRect {
    
    var middle: CGPoint {
        return CGPoint(x: origin.x + 0.5 * width, y: origin.y + 0.5 * height)
    }
    
    func originOffsetFromCenter(offset: CGSize) -> CGPoint {
        return CGPoint(x: origin.x + 0.5 * (width - offset.width), y: origin.y + 0.5 * (height - offset.height))
    }
}
