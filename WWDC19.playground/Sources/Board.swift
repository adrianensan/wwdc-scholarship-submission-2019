import SpriteKit

public class Board: SKNode {
    
    static let tileCount: Int = 5
    
    public var editable: Bool {
        didSet {
            var delays = [Int](0..<(Board.tileCount * Board.tileCount))
            delays.shuffle()
            for i in 0..<Board.tileCount {
                for j in 0..<Board.tileCount {
                    tiles[i][j].run(.sequence([
                        .wait(forDuration: 0.005 * Double(delays.removeLast())),
                        .run { self.tiles[i][j].editable = self.editable }
                    ]))
                }
            }
        }
    }
    
    private let tiles: [[BoardTile]]
    private var boardObjects: [BoardObject]
    
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
        boardObjects = [BoardObject]()
        editable = false
        super.init()
        
        for row in tiles {
            for tile in row {
                tile.delegate = self
                addChild(tile)
            }
        }
        
        let car = Car()
        car.zPosition = 40
        car.delegate = self
        boardObjects.append(car)
        addChild(car)
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
        
        for boardObject in boardObjects {
            boardObject.updateSize()
        }
    }
    
    public func update(_ delta: CGFloat) {
        for i in 0..<Board.tileCount {
            for j in 0..<Board.tileCount {
                tiles[i][j].update(delta)
            }
        }
        
        for boardObject in boardObjects {
            boardObject.update(delta: delta)
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
    
    public func tileDropped(to point: CGPoint, tile: Tile) -> Bool {
        guard let boardTile = getTileAt(point: point) else { return false }
        boardTile.tile = tile
        return true
    }
    
    private func getTileAt(point: CGPoint) -> BoardTile? {
        for node in nodes(at: point) {
            if let node = node as? BoardTile { return node }
        }
        return nil
    }
}

extension Board: CarDelegate {
    public func queryNearestRoadTangent(point: CGPoint, direction: CGFloat) -> (point: CGPoint, tangent: CGFloat) {
        let boardTile = getTileAt(point: point)
        return (point: CGPoint(x: -100, y: -100), tangent: 0.5 * .pi)
    }
}
