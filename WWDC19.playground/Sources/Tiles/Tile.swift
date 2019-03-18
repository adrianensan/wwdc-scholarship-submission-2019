import SpriteKit

public class Tile: SKNode { 

    let shadow: SKSpriteNode
    let baseTile: SKSpriteNode
    
    public override init() {
        shadow = SKSpriteNode()
        baseTile = SKSpriteNode()
        super.init()
        
        shadow.zPosition = ZPosition.tileShadow
        addChild(shadow)
        
        baseTile.zPosition = ZPosition.tile
        addChild(baseTile)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Tile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        shadow.texture = Texture.tileShadow
        shadow.size = Texture.tileShadow.size()
        
        baseTile.size = Size.boardTile
    }
    
    public func update(_ delta: CGFloat) {
    }
    
}
