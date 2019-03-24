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
                self.boardTileDelegate?.tileSelected(tile: tile)
            }
        }
    }
    
    var boardTileDelegate: BoardTileDelegate?
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
    
    private let placeholderTile: PlaceholderTile
    private let highlightOverlay: SKSpriteNode
    private var selected: Bool
    
    public override init() {
        tile = nil
        placeholderTile = PlaceholderTile()
        highlightOverlay = SKSpriteNode()
        editable = false
        selected = false
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
        return tile?.type.closestRoadPoint(point: point, direction: direction, tilePosition: position, tileRotation: tile!.zRotation)
    }
}

protocol BoardTileDelegate {
    func tileSelected(tile: Tile?)
}

extension BoardTile: NewTileDelegate {
    public func tileMoved(to point: CGPoint) {
        tile?.zPosition = ZPosition.overlayTile
        tile = nil
        delegate?.tileMoved(to: point)
        boardTileDelegate?.tileSelected(tile: nil)
    }
    
    public func tileDropped(tile: Tile) -> Bool {
        let successfullyMoved = delegate?.tileDropped(tile: tile) ?? false
        if !successfullyMoved { tile.removeFromParent() }
        return successfullyMoved
    }
}
