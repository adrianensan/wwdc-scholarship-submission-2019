import SpriteKit

public struct GrassAccentTextureGenerator {
    static func generate() -> SKTexture! {
        let width: CGFloat = CGFloat.random(in: 0.03..<0.05) * Size.boardTile.width
        let height: CGFloat = CGFloat.random(in: 0.05..<0.075) * Size.boardTile.height
        
        let node = SKNode()
        
        let tileBase = SKShapeNode()
        tileBase.fillColor = Color.grassAccent
        tileBase.lineWidth = 0
        tileBase.path = {
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: -0.5 * width, y: -0.5 * height),
                CGPoint(x: -0, y: 0.5 * height),
                CGPoint(x: 0.5 * width, y: -0.5 * height)
                ])
            path.closeSubpath()
            return path
        }()
        node.addChild(tileBase)
        
        return SKView().texture(from: node)
    }
}
