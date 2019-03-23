import SpriteKit

public class CarSidebarSection: SKNode {
    
    var objectDelegate: BoardObjectDelegate?
    
    var editingBoard: Bool {
        didSet {
            run(.fadeAlpha(to: editingBoard ? 0 : 1, duration: Duration.magnetSnapAnimation))
            car?.run(.fadeAlpha(to: editingBoard ? 0 : 1, duration: Duration.magnetSnapAnimation))
        }
    }
    
    private let title: SKLabelNode
    private var car: Car?
    
    public override init() {
        title = SKLabelNode()
        editingBoard = false
        super.init()
        
        title.text = "Add Car"
        title.fontName = Constant.font
        title.zPosition = ZPosition.overlayTile
        addChild(title)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"CarSidebarSection\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        title.fontSize = Size.subTitleFontSize
        title.position.y = 0.1 * Size.sidebarWidth
        
        if car == nil { newCar() }
        else if let car = car {
            car.updateSize()
            car.position = position
            car.position.x += 0.3 * Size.carHeight
        }
    }
    
    public func update(_ currentTime: TimeInterval) {
        
    }
    
    public func newCar() {
        car = Car()
        if let car = car {
            car.delegate = self
            car.zRotation = 0.5 * .pi
            car.zPosition = ZPosition.overlayTile
            parent?.addChild(car)
            car.updateSize()
            car.position = position
            car.position.x += 0.3 * Size.carHeight
            car.run(.sequence([
                .scale(to: 1.2, duration: 0.1),
                .scale(to: 1, duration: 0.05)
            ]))
        }
    }
    
    private func updatePositioning() {
        
    }
}

extension CarSidebarSection: BoardObjectDelegate {
    public func objectMoved(to point: CGPoint) {
        objectDelegate?.objectMoved(to: point)
    }
    
    public func objectDropped(object: BoardObject) -> Bool {
        if objectDelegate?.objectDropped(object: object) ?? false {
            newCar()
            return true
        }
        else {
            car?.run(.move(to: CGPoint(x: position.x + 0.3 * Size.carHeight,
                                       y: position.y),
                           duration: Duration.magnetSnapAnimation),
                     timingMode: .easeInEaseOut)
            return false
        }
    }
}
