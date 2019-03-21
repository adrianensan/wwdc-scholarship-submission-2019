import SpriteKit

public class BoardTile: SKNode {
    
    var tile: Tile? {
        willSet {
            if let _ = newValue { tile?.removeFromParent() }
        }
        didSet {
            highlighted = false
            
            guard let tile = tile else { return }
            tile.zPosition = 0
            tile.delegate = self
            tile.movable = editable
            tile.removeFromParent()
            parent?.addChild(tile)
            updateSize()
        }
    }
    private let placeholderTile: PlaceholderTile
    private let highlightOverlay: SKSpriteNode
    
    var delegate: NewTileDelegate?
    
    var editable: Bool {
        didSet { tile?.movable = editable }
    }
    
    var highlighted: Bool {
        get { return !highlightOverlay.isHidden }
        set { highlightOverlay.isHidden = !newValue }
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
        highlightOverlay.isHidden = true
        highlightOverlay.zPosition = ZPosition.tileHighlight
        addChild(highlightOverlay)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"PlaceholderTile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        placeholderTile.updateSize()
        highlightOverlay.size = Size.boardTile
        tile?.updateSize()
        tile?.position = position
    }
    
    public func update(_ delta: CGFloat) {
        placeholderTile.update(delta)
        tile?.update(delta)
        if editable && placeholderTile.alpha < 1 {
            placeholderTile.alpha += delta * 10
        }
        else if !editable && placeholderTile.alpha > 0 {
            placeholderTile.alpha -= delta * 10
        }
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
