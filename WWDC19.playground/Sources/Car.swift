import SpriteKit

public class Car: SKNode {
    
    let shape: SKSpriteNode
    
    override init() {
        shape = SKSpriteNode()
        super.init()
        
        addChild(shape)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Car\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        shape.texture = Texture.car
        shape.size = CGSize(width: 80, height: 180)
    }
}
