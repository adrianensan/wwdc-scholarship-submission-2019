import SpriteKit

public struct TileShadowTextureGenerator {
    static func generate() -> SKTexture! {
        let node = SKNode()
        
        let borderShape = SKShapeNode()
        borderShape.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        borderShape.strokeColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        borderShape.lineWidth = 0.025 * Size.boardTile.width
        borderShape.lineJoin = .round
        borderShape.glowWidth = 0.025 * Size.boardTile.width
        borderShape.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: Size.boardTile.offset,
                                size: Size.boardTile))
            path.closeSubpath()
            return path
        }()
        node.addChild(borderShape)
        
        return SKView().texture(from: node)
    }
}
