import SpriteKit

public struct Texture {
    
    static var placeholderTile: SKTexture!
    static var car: SKTexture!
    
    static func regenerateTextures() {
        placeholderTile = generatePlaceholderTileTexture()
        car = generateCarTexture()
    }
    
    static private func generatePlaceholderTileTexture() -> SKTexture! {
        let node = SKNode()
        
        let borderShape = SKShapeNode()
        borderShape.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        borderShape.strokeColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        borderShape.lineWidth = 0.025 * BoardTile.size.width
        borderShape.lineJoin = .round
        borderShape.glowWidth = 0.05 * BoardTile.size.width
        borderShape.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: BoardTile.size.offset, size: BoardTile.size))
            path.closeSubpath()
            return path
        }()
        node.addChild(borderShape)
        
        return SKView().texture(from: node,
                                crop: CGRect(origin: node.calculateAccumulatedFrame().originOffsetFromCenter(offset: BoardTile.size),
                                             size: BoardTile.size))
    }
    
    static private func generateCarTexture() -> SKTexture! {
        let width: CGFloat = 80
        let halfWidth: CGFloat = 0.5 * width
        
        let height: CGFloat = 200
        let halfHeight: CGFloat = 0.5 * width
        
        let carNode = SKNode()
        
        for i in 0..<4 {
            let wheel = SKSpriteNode()
            wheel.size = CGSize(width: 0.25 * width,
                                height: 0.15 * width)
            wheel.color = .black
            wheel.position.x = CGFloat(i < 2 ? 1 : -1) * halfWidth
            wheel.position.y = CGFloat(i % 2 == 0 ? 1 : -1) * 0.5 * halfHeight
            carNode.addChild(wheel)
        }
        
        let baseCarShape = SKShapeNode()
        baseCarShape.fillColor = .red
        baseCarShape.strokeColor = .red
        baseCarShape.lineWidth = 0.1 * width
        baseCarShape.lineJoin = .round
        baseCarShape.path = {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -halfWidth, y: -0.8 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: halfWidth, y: -0.8 * halfHeight),
                              control: CGPoint(x: 0, y: -halfHeight))
            path.addLine(to: CGPoint(x: halfWidth, y: 0.7 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: -halfWidth, y: 0.7 * halfHeight),
                              control: CGPoint(x: 0, y: halfHeight))
            path.closeSubpath()
            return path
        }()
        carNode.addChild(baseCarShape)
        
        let frontWindowShape = SKShapeNode()
        frontWindowShape.fillColor = .black
        frontWindowShape.strokeColor = .black
        frontWindowShape.lineWidth = 0.1 * width
        frontWindowShape.lineJoin = .round
        frontWindowShape.path = {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -0.8 * halfWidth, y: 0.25 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: 0.8 * halfWidth, y: 0.25 * halfHeight),
                              control: CGPoint(x: 0, y: 0.35 * halfHeight))
            path.addLine(to: CGPoint(x: 0.9 * halfWidth, y: 0.4 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: -0.9 * halfWidth, y: 0.4 * halfHeight),
                              control: CGPoint(x: 0, y: 0.6 * halfHeight))
            path.closeSubpath()
            return path
        }()
        carNode.addChild(frontWindowShape)
        
        let backWindowShape = SKShapeNode()
        backWindowShape.fillColor = .black
        backWindowShape.strokeColor = .black
        backWindowShape.lineWidth = 0.1 * width
        backWindowShape.lineJoin = .round
        backWindowShape.path = {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -0.8 * halfWidth, y: -0.6 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: 0.8 * halfWidth, y: -0.6 * halfHeight),
                              control: CGPoint(x: 0, y: -0.8 * halfHeight))
            path.addLine(to: CGPoint(x: 0.8 * halfWidth, y: -0.55 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: -0.8 * halfWidth, y: -0.55 * halfHeight),
                              control: CGPoint(x: 0, y: -0.65 * halfHeight))
            path.closeSubpath()
            return path
        }()
        carNode.addChild(backWindowShape)
        
        return SKView().texture(from: carNode)
    }
}

