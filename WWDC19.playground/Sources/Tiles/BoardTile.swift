import SpriteKit

public class BoardTile: SKNode {
    
    static let size = CGSize(width: 50, height: 50)
    
    let tile: Tile?
    let placeholderTile: PlaceholderTile
    
    public override init() {
        tile = nil
        placeholderTile = PlaceholderTile()
        super.init()
        
        addChild(placeholderTile)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"PlaceholderTile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        placeholderTile.updateSize()
    }
    
    public func update(_ currentTime: TimeInterval) {
        placeholderTile.update(currentTime)
    }
}
