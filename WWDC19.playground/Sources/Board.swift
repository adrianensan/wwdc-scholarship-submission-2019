import SpriteKit

public class Board: SKNode {
    
    static let tileCount: Int = 5
    
    public var showPlaceholders: Bool {
        didSet {
            for i in 0..<Board.tileCount {
                for j in 0..<Board.tileCount {
                    tiles[i][j].showPlaceHolder = showPlaceholders
                }
            }
        }
    }
    
    private let tiles: [[BoardTile]]
    
    public override init() {
        tiles = {
            var tiles = [[BoardTile]]()
            for i in 0..<Board.tileCount {
                tiles.append([BoardTile]())
                for _ in 0..<Board.tileCount {
                    tiles[i].append(BoardTile())
                }
            }
            return tiles
        }()
        showPlaceholders = false
        super.init()
        
        for row in tiles {
            for tile in row {
                addChild(tile)
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Baord\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        for i in 0..<Board.tileCount {
            for j in 0..<Board.tileCount {
                tiles[i][j].updateSize()
                tiles[i][j].position.x = -0.5 * (Size.board.width - Size.boardTile.width) + CGFloat(i) * Size.boardTile.width
                tiles[i][j].position.y = -0.5 * (Size.board.height - Size.boardTile.height) + CGFloat(j) * Size.boardTile.height
            }
        }
    }
    
    public func update(_ delta: CGFloat) {
        for i in 0..<Board.tileCount {
            for j in 0..<Board.tileCount {
                tiles[i][j].update(delta)
            }
        }
    }
}

extension Board: NewTileDelegate {
    public func tileMoved(to point: CGPoint) {
        let tile = getTileAt(point: point)
        if tile == nil || !tile!.highlighted {
            for i in 0..<Board.tileCount {
                for j in 0..<Board.tileCount {
                    tiles[i][j].highlighted = false
                }
            }
        }
        
        tile?.highlighted = true
    }
    
    public func tileDropped(to point: CGPoint, type: TileType) {
        getTileAt(point: point)?.setType(type: type)
    }
    
    private func getTileAt(point: CGPoint) -> BoardTile? {
        for node in nodes(at: point) {
            if let node = node as? BoardTile { return node }
        }
        return nil
    }
}
