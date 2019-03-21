import SpriteKit

public class CurvedRoadTile: GrassTile {
    
    override var type: TileType { return TileType.curvedRoad }
    
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
        
        road.texture = Texture.curvedRoad
        road.size = Texture.curvedRoad.size()
        let offset: CGFloat = 0.5 * Size.boardTile.width - Size.roadLaneWidth - 0.5 * Size.roadDividerWidth - 0.5 * Size.roadOutlineWidth
        road.position = CGPoint(x: 0.5 * offset, y: -0.5 * offset)
    }
}
