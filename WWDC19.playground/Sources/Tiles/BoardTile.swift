import SpriteKit

public class BoardTile: SKNode {
    
    var tile: Tile?
    private let placeholderTile: PlaceholderTile
    private let highlightOverlay: SKSpriteNode
    
    var showPlaceHolder: Bool
    
    var highlighted: Bool {
        get { return !highlightOverlay.isHidden }
        set { highlightOverlay.isHidden = !newValue }
    }
    
    public override init() {
        tile = nil
        placeholderTile = PlaceholderTile()
        highlightOverlay = SKSpriteNode()
        showPlaceHolder = false
        super.init()
        
        placeholderTile.alpha = 0
        placeholderTile.zPosition = ZPosition.tilePlaceholder
        addChild(placeholderTile)
        
        highlightOverlay.color = SKColor(white: 1, alpha: 0.25)
        highlightOverlay.isHidden = true
        highlightOverlay.zPosition = ZPosition.tileHighlight
        addChild(highlightOverlay)
        
        if let tile = tile {
            tile.zPosition = ZPosition.tile
            addChild(tile)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"PlaceholderTile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        placeholderTile.updateSize()
        highlightOverlay.size = Size.boardTile
        tile?.updateSize()
    }
    
    public func update(_ delta: CGFloat) {
        placeholderTile.update(delta)
        tile?.update(delta)
        if showPlaceHolder && placeholderTile.alpha < 1 {
            placeholderTile.alpha += delta * 10
        }
        else if !showPlaceHolder && placeholderTile.alpha > 0 {
            placeholderTile.alpha -= delta * 10
        }
    }
    
    public func setType(type: TileType?) {
        if let tile = tile {
            tile.removeFromParent()
            self.tile = nil
        }
        
        if let type = type {
            tile = type.tile
            addChild(tile!)
            updateSize()
        }
        
        highlighted = false
    }
}
