import SpriteKit

public class PlaceholderTile: SKNode {
    
    private let square: SKSpriteNode
    
    private var flashingDirection: CGFloat
    
    public override init() {
        square = SKSpriteNode()
        flashingDirection = -0.005
        super.init()
        
        addChild(square)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"PlaceholderTile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        square.texture = Texture.placeholderTile
        square.size = Size.boardTile
    }
    
    public func update(_ delta: CGFloat) {
        //alpha += flashingDirection
        //if alpha >= 1 || alpha <= 0.8 {
        //    flashingDirection *= -1
       // }
    }
}
