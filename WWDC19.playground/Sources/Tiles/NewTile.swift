import SpriteKit

public protocol NewTileDelegate {
    func tileMoved(to point: CGPoint)
    func tileDropped(to point: CGPoint, type: TileType)
}

public class NewTile: SKNode {
    
    let type: TileType
    let tile: Tile
    
    var delegate: NewTileDelegate?
    
    public init(type: TileType) {
        self.type = type
        tile = type.tile
        super.init()

        tile.zPosition = ZPosition.tile
        addChild(tile)
        
        isUserInteractionEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Tile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        tile.updateSize()
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
        delegate?.tileDropped(to: position, type: type)
    }
    
    public func update(_ delta: CGFloat) {
    }
    
}
