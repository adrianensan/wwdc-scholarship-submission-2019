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
        let longSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.height : \CGSize.width
        let shortSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.width : \CGSize.height
        
        background.size[keyPath: shortSide] = 1.5 * Size.boardTile[keyPath: shortSide]
        background.size[keyPath: longSide] = Size.sceneSize[keyPath: longSide]
        
        for tile in tiles { tile.updateSize() }
        updatePositioning()
    }
    
    public func update(_ currentTime: TimeInterval) {

    }
    
    private func updatePositioning() {
        let longSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.height : \CGSize.width
        let shortSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.width : \CGSize.height
        let point1 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.x : \CGPoint.y
        let point2 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.y : \CGPoint.x
        
        background.position[keyPath: point1] = 0.5 * Size.sceneSize[keyPath: shortSide] + 0.5 * background.size[keyPath: shortSide] * (showing ? -1 : 1)
        background.position[keyPath: point2] = 0
        for i in 0..<tiles.count {
            let spacing = 1.25 * Size.boardTile.height
            tiles[i].position[keyPath: point1] = background.position[keyPath: point1]
            tiles[i].position[keyPath: point2] = 0.5 * (CGFloat(tiles.count) - 1) * spacing - CGFloat(i) * spacing
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
