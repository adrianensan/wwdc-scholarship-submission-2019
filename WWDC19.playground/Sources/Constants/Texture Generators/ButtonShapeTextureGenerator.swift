import SpriteKit

public struct ButtonShapeTextureGenerator {
    static func generate() -> SKTexture! {
        let node = SKNode()
        
        let tileBase = SKShapeNode()
        tileBase.fillColor = .white
        tileBase.lineWidth = 0
        tileBase.path = {
            let path = CGPath(roundedRect: Size.textButton.ceneteredRect,
                              cornerWidth: 0.5 * Size.textButton.height,
                              cornerHeight: 0.5 * Size.textButton.height,
                              transform: nil)
            return path
        }()
        node.addChild(tileBase)
        
        return SKView().texture(from: node)
    }
}
