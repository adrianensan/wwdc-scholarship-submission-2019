import SpriteKit

extension SKNode {

}

extension CGSize {
    
    var middle: CGPoint {
        return CGPoint(x: 0.5 * width, y: 0.5 * height)
    }
    
    var offset: CGPoint {
        return CGPoint(x: -0.5 * width, y: -0.5 * height)
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
