import SpriteKit

public struct TileOptionsPopupTextureGenerator {
    static func generate() -> SKTexture! {
        let node = SKNode()
        
        let shape = SKShapeNode()
        shape.fillColor = .black
        shape.strokeColor = .black
        shape.lineWidth = 0.001 * Size.boardTile.width
        shape.glowWidth = 0.02 * Size.boardTile.width
        shape.path = {
            let path = CGPath(roundedRect: CGSize(width: 0.9 * Size.boardTile.width,
                                                  height: 0.4 * Size.boardTile.height).ceneteredRect,
                              cornerWidth: 0.15 * Size.boardTile.width,
                              cornerHeight: 0.25 * Size.boardTile.height,
                              transform: nil)
            return path
        }()
        node.addChild(shape)
        
        return SKView().texture(from: node)
    }
}
