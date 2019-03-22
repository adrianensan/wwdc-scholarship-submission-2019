import SpriteKit

public struct CarTextureGenerator {
    static func generate() -> SKTexture! {
        let width: CGFloat = 2.75 * Size.roadLaneWidth
        let halfWidth: CGFloat = 0.5 * width
        
        let halfHeight: CGFloat = 1.35 * width
        
        let carNode = SKNode()
        
        let baseCarShape = SKShapeNode()
        baseCarShape.fillColor = .red
        baseCarShape.strokeColor = .black
        baseCarShape.lineWidth = 0.025 * width
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

