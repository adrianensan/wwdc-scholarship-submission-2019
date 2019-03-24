import SpriteKit

public class Board: SKNode {
    
    static let tileCount: Int = 5
    
    public var editable: Bool {
        didSet {
            updatePositioning()
            for i in 0..<Board.tileCount {
                for j in 0..<Board.tileCount {
                    tiles[i][j].run(.sequence([
                        .wait(forDuration: Double(editable ? (Board.tileCount - i) * Board.tileCount : i * Board.tileCount) * 0.005),
                        .run { self.tiles[i][j].editable = self.editable }
                    ]))
                }
            }
            for boardObject in boardObjects {
                boardObject.run(.fadeAlpha(to: editable ? 0 : 1, duration: Duration.magnetSnapAnimation))
            }
            boardTileOptionsPopup.tile = nil
        }
    }
    
    private let tiles: [[BoardTile]]
    private var boardObjects: [BoardObject]
    private var boardTileOptionsPopup: BoardTileOptionsPopup
    
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
        boardTileOptionsPopup = BoardTileOptionsPopup()
        editable = false
        super.init()
        
        for row in tiles {
            for tile in row {
                tile.delegate = self
                tile.boardTileDelegate = self
                addChild(tile)
            }
        }
        
        addChild(boardTileOptionsPopup)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Baord\" is only intended to be instantiated through code")
    }
    
    public func clear() {
        for i in 0..<Board.tileCount {
            for j in 0..<Board.tileCount {
                tiles[i][j].tile?.removeFromParent()
                tiles[i][j].tile = nil
            }
        }
    }
    
    public func updateSize() {
        for i in 0..<Board.tileCount {
            for j in 0..<Board.tileCount {
                tiles[i][j].updateSize()
            }
        }
        
        for boardObject in boardObjects {
            boardObject.updateSize()
        }
        boardTileOptionsPopup.updateSize()
        updatePositioning()
    }
    
    public func updatePositioning() {
        for i in 0..<Board.tileCount {
            for j in 0..<Board.tileCount {
                var newPosition: CGPoint = .zero
                newPosition.x = -0.5 * (Size.board.width - Size.boardTile.width) + CGFloat(i) * Size.boardTile.width
                newPosition.y = -0.5 * (Size.board.height - Size.boardTile.height) + CGFloat(j) * Size.boardTile.height
                let point1 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.x : \CGPoint.y
                newPosition[keyPath: point1] -= (editable ? 0.5 : 0.175) * 2.75 * Size.boardTile.width
                
                tiles[i][j].run(.move(to: newPosition, duration: Duration.magnetSnapAnimation),
                                timingMode: .easeInEaseOut)
                tiles[i][j].tile?.run(.move(to: newPosition, duration: Duration.magnetSnapAnimation),
                                      timingMode: .easeInEaseOut)
            }
        }
    }
    
    public func update(_ delta: CGFloat) {
        for i in 0..<Board.tileCount {
            for j in 0..<Board.tileCount {
                tiles[i][j].update(delta)
            }
        }
        
        for i in (0..<boardObjects.count).reversed() {
            boardObjects[i].update(delta: delta)
            if boardObjects[i].position.distance > Size.sceneObjectRadius {
                boardObjects[i].removeFromParent()
                boardObjects.remove(at: i)
            }
        }
    }
    
    private func getTileAt(point: CGPoint) -> BoardTile? {
        for node in nodes(at: point) {
            if let node = node as? BoardTile { return node }
        }
        return nil
    }
}

extension Board: BoardObjectDelegate {
    public func objectMoved(to point: CGPoint) {
        let tile = getTileAt(point: point)
        if tile == nil || !tile!.highlighted {
            for i in 0..<Board.tileCount {
                for j in 0..<Board.tileCount {
                    //tiles[i][j].highlighted = false
                }
            }
        }
        
        //tile?.highlighted = true
    }
    
    public func objectDropped(object: BoardObject) -> Bool {
        boardObjects.append(object)
        object.move(toParent: self)
        if let object = object as? Car { object.carDelegate = self }
        return true
    }
}

extension Board: BoardTileDelegate {
    func tileSelected(tile: Tile?) {
        boardTileOptionsPopup.tile = tile
    }
}

extension Board: NewTileDelegate {
    public func tileMoved(to point: CGPoint) {
        boardTileOptionsPopup.tile = nil
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
    
    public func tileDropped(tile: Tile) -> Bool {
        guard let boardTile = getTileAt(point: tile.position) else { return false }
        boardTile.tile = tile
        return true
    }
}

extension Board: CarDelegate {
    public func queryNearestRoadTangent(point: CGPoint, direction: CGFloat) -> CGPoint? {
        return getTileAt(point: point)?.queryNearestRoadTangent(point: point, direction: direction)
    }
}
