import SpriteKit

public class Car: BoardObject {
    
    public static let maxTurnSpeedPerSecond: CGFloat = .pi
    public static let maxDriveSpeedPerSecond: CGFloat = .pi
    
    public var carDelegate: CarDelegate?
    
    private var randomTurnDirection: CGFloat
    private let shape: SKSpriteNode
    private let wheels: [SKSpriteNode]
    private let frontWheels: [SKSpriteNode]
    
    public override var zRotation: CGFloat {
        didSet {
            let normalizedAngle = zRotation.normalizedAngle
            if zRotation != normalizedAngle { zRotation = normalizedAngle }
        }
    }
    
    override init() {
        randomTurnDirection = CGFloat.random(in: 0...1) < 0.5 ? 1 : -1
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
        shape.colorBlendFactor = 1
        shape.color = Color.randomCar
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
        position += Car.maxDriveSpeedPerSecond.inDirectionOf(rotation: zRotation + 0.5 * .pi) * delta * 25
        
        let desiredAngle: CGFloat
        let carFrontPosition = position + (0.7 * Size.carHeight).inDirectionOf(rotation: zRotation + 0.5 * .pi)
        if let targetPoint = carDelegate?.queryNearestRoadTangent(point: carFrontPosition, direction: zRotation + 0.5 * .pi) {
            desiredAngle = (carFrontPosition.angle(to: targetPoint) - 0.5 * .pi).normalizedAngle
        }
        else {
            desiredAngle = zRotation + CGFloat.random(in: 0..<0.2) * .pi * randomTurnDirection
            if CGFloat.random(in: 0..<1) < 0.005 { randomTurnDirection *= -1 }
        }
        
        let moveAmount: CGFloat = .shortestAngle(from: zRotation, to: desiredAngle)
        let turnAmount: CGFloat = min(0.15 * moveAmount, Car.maxTurnSpeedPerSecond)
        zRotation += turnAmount * delta * 15
        for wheel in frontWheels { wheel.zRotation = turnAmount * 7.5 }
    }
}

public protocol CarDelegate {
    func queryNearestRoadTangent(point: CGPoint, direction: CGFloat) -> CGPoint?
}
