import SpriteKit

public class Tile: SKNode {
    
    var type: TileType { return TileType.grass }

    let shadow: SKSpriteNode
    let baseTile: SKSpriteNode
    
    var delegate: NewTileDelegate?
    
    var movable: Bool {
        get { return isUserInteractionEnabled }
        set { isUserInteractionEnabled = newValue }
    }
    
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
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let scene = scene {
            position = touch.location(in: scene)
            delegate?.tileMoved(to: position)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = delegate?.tileDropped(to: position, tile: self)
    }
    
    public func updateSize() {
        shadow.texture = Texture.tileShadow
        shadow.size = Texture.tileShadow.size()
        
        baseTile.size = Size.boardTile
    }
    
    public func update(_ delta: CGFloat) {
    }
    
}

protocol NewTileDelegate: AnyObject {
    func tileMoved(to: CGPoint)
    func tileDropped(to: CGPoint, tile: Tile) -> Bool
}
