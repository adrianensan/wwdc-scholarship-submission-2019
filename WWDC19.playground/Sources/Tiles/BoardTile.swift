import SpriteKit

public class BoardTile: SKNode {
    
    var tile: Tile? {
        willSet {
            if let _ = newValue { tile?.removeFromParent() }
        }
        didSet {
            highlighted = false
            
            guard let tile = tile else { return }
            tile.delegate = self
            tile.movable = editable
            tile.removeFromParent()
            parent?.addChild(tile)
            tile.run(.move(to: position, duration: Duration.magnetSnapAnimation)) {
                tile.zPosition = 0
            }
        }
    }
    private let placeholderTile: PlaceholderTile
    private let highlightOverlay: SKSpriteNode
    
    var delegate: NewTileDelegate?
    
    var editable: Bool {
        didSet {
            tile?.movable = editable
            placeholderTile.run(.group([
                .fadeAlpha(to: editable ? 1 : 0, duration: Duration.magnetSnapAnimation)
            ]))
        }
    }
    
    var highlighted: Bool {
        get { return highlightOverlay.alpha == 1 }
        set {
            highlightOverlay.run(.fadeAlpha(to: newValue ? 1 : 0,
                                            duration: Duration.magnetSnapAnimation))
            
        }
    }
    
    public override init() {
        tile = nil
        placeholderTile = PlaceholderTile()
        highlightOverlay = SKSpriteNode()
        editable = false
        super.init()
        
        placeholderTile.alpha = 0
        placeholderTile.zPosition = ZPosition.tilePlaceholder
        addChild(placeholderTile)
        
        highlightOverlay.color = SKColor(white: 1, alpha: 0.25)
        highlightOverlay.alpha = 0
        highlightOverlay.zPosition = ZPosition.tileHighlight
        addChild(highlightOverlay)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"BoardTile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        placeholderTile.updateSize()
        highlightOverlay.size = Size.boardTile
        tile?.updateSize()
    }
    
    public func update(_ delta: CGFloat) {
        placeholderTile.update(delta)
        tile?.update(delta)
    }
    
    public func queryNearestRoadTangent(point: CGPoint, direction: CGFloat) -> CGPoint? {
        return tile?.type.closestRoadPoint(point: point, direction: direction, tileRotation: tile!.zRotation)
    }
}

extension BoardTile: NewTileDelegate {
    public func tileMoved(to point: CGPoint) {
        tile?.zPosition = ZPosition.overlayTile
        tile = nil
        delegate?.tileMoved(to: point)
    }
    
    public func tileDropped(to point: CGPoint, tile: Tile) -> Bool {
        let successfullyMoved = delegate?.tileDropped(to: point, tile: tile) ?? false
        if !successfullyMoved { tile.removeFromParent() }
        return successfullyMoved
    }
}
