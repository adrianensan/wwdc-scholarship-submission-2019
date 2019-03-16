import SpriteKit

public class Scene: SKScene {
    
    let board: Board
    let car: Car
    
    override public init() {
        Texture.regenerateTextures()
        board = Board()
        car = Car()
        super.init(size: .zero)
        
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .brown
        
        car.updateSize()
        board.updateSize()
        addChild(board)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Scene\" is only intended to be instantiated through code")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        board.updateSize()
        car.updateSize()
    }
    
    override public func update(_ currentTime: TimeInterval) {
        board.update(currentTime)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
}

