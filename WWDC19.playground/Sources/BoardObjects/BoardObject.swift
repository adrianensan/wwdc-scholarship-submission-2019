import SpriteKit

public class BoardObject: SKNode {
    
    var delegate: BoardObjectDelegate?
    
    override init() {
        super.init()
        
        isUserInteractionEnabled = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Class \"BoardObject\" is only intended to be instantiated through code")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        zPosition = ZPosition.topLevelDragging
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let scene = scene {
            position = touch.location(in: scene)
            delegate?.objectMoved(to: position)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = delegate?.objectDropped(object: self)
    }
    
    public func updateSize() {
    }
    
    public func update(delta: CGFloat) {
    }
}

protocol BoardObjectDelegate: AnyObject {
    func objectMoved(to: CGPoint)
    func objectDropped(object: BoardObject) -> Bool
}
