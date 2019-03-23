import SpriteKit

public class TileSelector: SKNode {
    
    var tiles: [Tile]
    
    var delegate: NewTileDelegate?
    
    public override init() {
        tiles = {
            var tiles = [Tile]()
            for tileType in TileType.allCases {
                tiles.append(tileType.tile)
            }
            return tiles
        }()
        super.init()
        
        for tile in tiles {
            tile.delegate = self
            tile.movable = true
            tile.zPosition = ZPosition.overlayTile
            addChild(tile)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"TileSelector\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        for tile in tiles { tile.updateSize() }
        updatePositioning()
    }
    
    public func update(_ currentTime: TimeInterval) {

    }
    
    private func updatePositioning(animate: Bool = false) {
        let longSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.height : \CGSize.width
        let shortSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.width : \CGSize.height
        let point1 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.x : \CGPoint.y
        let point2 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.y : \CGPoint.x
        
        let pos: CGFloat = 0.5 * Size.sceneSize[keyPath: shortSide] - 0.75 * Size.boardTile[keyPath: shortSide]
        
        for i in 0..<tiles.count {
            let spacing = 1.25 * Size.boardTile.height
            var target: CGPoint = .zero
            target[keyPath: point1] = pos - ((i < 4 ? spacing : 0)) 
            target[keyPath: point2] = (Size.sceneSize.width > Size.sceneSize.height ? 1 : -1) *
                (1 * spacing - CGFloat(i % 4) * spacing)
            tiles[i].run(.move(to: target, duration: animate ? Duration.magnetSnapAnimation : 0))
            tiles[i].zPosition = ZPosition.overlayTile
        }
    }
}

extension TileSelector: NewTileDelegate {
    public func tileMoved(to point: CGPoint) {
        delegate?.tileMoved(to: point)
    }
    
    public func tileDropped(to point: CGPoint, tile: Tile) -> Bool {
        let successfullyDropped = delegate?.tileDropped(to: point, tile: tile) ?? false
        if successfullyDropped {
            let index = TileType.allCases.firstIndex(of: tile.type)!
            tiles[index] = tile.type.tile
            tiles[index].delegate = self
            tiles[index].movable = true
            tiles[index].zPosition = ZPosition.overlayTile
            tiles[index].updateSize()
            addChild(tiles[index])
            
            tiles[index].setScale(0)
            tiles[index].run(.sequence([
                .scale(to: 1.2, duration: 0.1),
                .scale(to: 1, duration: 0.05)
            ]))
            updatePositioning()
        }
        updatePositioning(animate: true)
        return successfullyDropped
    }
}
