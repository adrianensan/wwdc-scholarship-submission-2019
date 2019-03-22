import SpriteKit

public class BoardObject: SKNode {
    
    override init() {
        super.init()
        
        isUserInteractionEnabled = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Class \"BoardObject\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
    }
    
    public func update(delta: CGFloat) {
    }
}
