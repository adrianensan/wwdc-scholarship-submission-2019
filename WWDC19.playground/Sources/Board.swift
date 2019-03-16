import SpriteKit

public class Board: SKNode {
    
    static let size: Int = 5
    
    let tiles: [[BoardTile]]
    
    public override init() {
        tiles = {
            var tiles = [[BoardTile]]()
            for i in 0..<Board.size {
                tiles.append([BoardTile]())
                for _ in 0..<Board.size {
                    tiles[i].append(BoardTile())
                }
            }
            return tiles
        }()
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
        for i in 0..<Board.size {
            for j in 0..<Board.size {
                tiles[i][j].updateSize()
                tiles[i][j].position.x =
                    -0.5 * (CGFloat(Board.size) * BoardTile.size.width - BoardTile.size.width) +
                    CGFloat(i) * BoardTile.size.width
                tiles[i][j].position.y =
                    -0.5 * (CGFloat(Board.size) * BoardTile.size.height - BoardTile.size.height) +
                    CGFloat(j) * BoardTile.size.height
            }
        }
    }
    
    public func update(_ currentTime: TimeInterval) {
        for i in 0..<Board.size {
            for j in 0..<Board.size {
                tiles[i][j].update(currentTime)
            }
        }
    }
    
}

