import SpriteKit

public struct TilePlaceholderTextureGenerator {
    static func generate() -> SKTexture! {
        let node = SKNode()
        
        let clipNodeMask = SKShapeNode()
        clipNodeMask.fillColor = .black
        clipNodeMask.lineWidth = 0
        clipNodeMask.lineJoin = .round
        clipNodeMask.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: CGSize(width: 0.95 * Size.boardTile.width,
                                               height: 0.95 * Size.boardTile.height).offset,
                                size: CGSize(width: 0.97 * Size.boardTile.width,
                                             height: 0.97 * Size.boardTile.height)))
            path.closeSubpath()
            return path
        }()
        
        let clipNode = SKCropNode()
        clipNode.maskNode = clipNodeMask
        
        let borderShape = SKShapeNode()
        borderShape.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        borderShape.strokeColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        borderShape.lineWidth = 0.06 * Size.boardTile.width
        borderShape.lineJoin = .round
        borderShape.glowWidth = 0.075 * Size.boardTile.width
        borderShape.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: Size.boardTile.offset,
                                size: Size.boardTile))
            path.closeSubpath()
            return path
        }()
        node.addChild(borderShape)
        
        clipNode.addChild(node)
        
        return SKView().texture(from: clipNode,
                                crop: CGRect(origin: clipNode.calculateAccumulatedFrame().originOffsetFromCenter(offset: Size.boardTile),
                                             size: Size.boardTile))
    }
}
