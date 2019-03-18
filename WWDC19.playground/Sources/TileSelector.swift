import SpriteKit

public class TileSelector: SKNode {
    
    let background: SKSpriteNode
    let tiles: [NewTile]
    
    var delegate: NewTileDelegate?
    var showing: Bool {
        didSet {
            updatePositioning()
        }
    }
    
    public override init() {
        background = SKSpriteNode()
        tiles = {
            var tiles = [NewTile]()
            for tileType in TileType.allCases {
                tiles.append(NewTile(type: tileType))
            }
            return tiles
        }()
        showing = false
        super.init()
        
        background.color = .black
        background.zPosition = ZPosition.overlay
        addChild(background)
        
        for tile in tiles {
            tile.delegate = self
            tile.zPosition = ZPosition.overlayTile
            addChild(tile)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"TileSelector\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        background.size.width = 1.5 * Size.boardTile.width
        background.size.height = Size.sceneSize.height
        
        for tile in tiles { tile.updateSize() }

    }
    
    public func update(_ currentTime: TimeInterval) {

    }
    
    private func updatePositioning() {
        background.position.x = 0.5 * Size.sceneSize.width + 0.5 * background.size.width * (showing ? -1 : 1)
        for i in 0..<tiles.count {
            let spacing = 1.25 * Size.boardTile.height
            tiles[i].position.x = background.position.x
            tiles[i].position.y = 0.5 * (CGFloat(tiles.count) - 1) * spacing - CGFloat(i) * spacing
        }
    }
}

extension TileSelector: NewTileDelegate {
    public func tileMoved(to point: CGPoint) {
        delegate?.tileMoved(to: point)
    }
    
    public func tileDropped(to point: CGPoint, type: TileType) {
        delegate?.tileDropped(to: point, type: type)
        updatePositioning()
    }
}
