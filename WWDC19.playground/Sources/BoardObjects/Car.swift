import SpriteKit

public class Car: BoardObject {
    
    public static let maxTurnSpeedPerSecond: CGFloat = .pi
    public static let maxDriveSpeedPerSecond: CGFloat = .pi
    
    public var delegate: CarDelegate?
    
    private let shape: SKSpriteNode
    private let wheels: [SKSpriteNode]
    private let frontWheels: [SKSpriteNode]
    
    override init() {
        shape = SKSpriteNode()
        wheels = {
            var wheels = [SKSpriteNode]()
            for _ in 0..<4 { wheels.append(SKSpriteNode()) }
            return wheels
        }()
        frontWheels = [wheels[0], wheels[1]]
        super.init()
        
        shape.zPosition = ZPosition.car
        shape.anchorPoint.y = 0.2
        addChild(shape)
        
        for wheel in wheels {
            wheel.zPosition = ZPosition.carWheel
            wheel.color = .black
            shape.addChild(wheel)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Car\" is only intended to be instantiated through code")
    }
    
    override public func updateSize() {
        shape.texture = Texture.car
        shape.size = Texture.car.size()
        
        for i in 0..<4 {
            wheels[i].size = CGSize(width: 0.2 * shape.size.width,
                                    height: 0.2 * shape.size.height)
            wheels[i].position.x = CGFloat(i % 2 == 0 ? 1 : -1) * 0.45 * shape.size.width
            wheels[i].position.y = CGFloat(i < 2 ? 0.55 : 0) * shape.size.height
        }
    }
    
    override public func update(delta: CGFloat) {
        let target = delegate?.queryNearestRoadTangent(point: position, direction: zRotation)
        let turnAmount: CGFloat = min(0.1 * ((target?.tangent ?? zRotation) - zRotation), Car.maxTurnSpeedPerSecond)
        zRotation += turnAmount * delta * 15
        for wheel in frontWheels { wheel.zRotation = turnAmount * 7.5 }
        position.x -= Car.maxDriveSpeedPerSecond * sin(zRotation) * delta * 25
        position.y += Car.maxDriveSpeedPerSecond * cos(zRotation) * delta * 25
    }
}

public protocol CarDelegate {
    func queryNearestRoadTangent(point: CGPoint, direction: CGFloat) -> (point: CGPoint, tangent: CGFloat)
}
