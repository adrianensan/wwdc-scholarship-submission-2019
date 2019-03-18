import SpriteKit

public class StraightRoadTile: GrassTile {
    
    let road: SKSpriteNode
    
    public override init() {
        road = SKSpriteNode()
        super.init()
        
        road.zPosition = ZPosition.road
        addChild(road)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"StraightRoadTile\" is only intended to be instantiated through code")
    }
    
    override public func updateSize() {
        super.updateSize()
        
        road.texture = Texture.straightRoad
        road.size = Texture.straightRoad.size()
    }
}
