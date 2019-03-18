import SpriteKit

public struct GrassTileTextureGenerator {
    static func generate() -> SKTexture! {
        let node = SKNode()
        
        let tileBase = SKShapeNode()
        tileBase.fillColor = Color.grass
        tileBase.lineWidth = 0
        tileBase.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: Size.boardTile.offset,
                                size: Size.boardTile))
            path.closeSubpath()
            return path
        }()
        node.addChild(tileBase)
        
        return SKView().texture(from: node)
    }
}
