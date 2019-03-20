import SpriteKit

public class GrassTile: Tile {
    
    override var type: TileType { return TileType.grass }
    
    let grassAccents: [(node: SKSpriteNode, position: CGPoint)]
    
    public override init() {
        grassAccents = {
            var grassAccents = [(SKSpriteNode, CGPoint)]()
            let numOfAccents = Int.random(in: 5..<30)
            for _ in 0..<numOfAccents {
                let position = CGPoint(x: CGFloat.random(in: -0.425..<0.425),
                                       y: CGFloat.random(in: -0.425..<0.425))
                let grassAccent = SKSpriteNode()
                grassAccent.zPosition = ZPosition.tileAccent
                grassAccents.append((grassAccent, position))
                
            }
            return grassAccents
        }()
        super.init()
        
        for grassAccent in grassAccents { addChild(grassAccent.node) }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"GrassTile\" is only intended to be instantiated through code")
    }
    
    override public func updateSize() {
        baseTile.texture = Texture.grassTile
        super.updateSize()
        
        for accent in grassAccents {
            accent.node.position.x = accent.position.x * Size.boardTile.width
            accent.node.position.y = accent.position.y * Size.boardTile.height
            accent.node.texture = Texture.grassAccent
            accent.node.size = Texture.grassAccent.size()
        }
    }
}
