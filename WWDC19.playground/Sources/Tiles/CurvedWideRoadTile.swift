import SpriteKit

public class CurvedWideRoadTile: GrassTile {
    
    override var type: TileType { return TileType.curvedWideRoad }
    
    let road: SKSpriteNode
    
    public override init() {
        road = SKSpriteNode()
        super.init()
        
        road.zPosition = ZPosition.road
        addChild(road)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"CurvedWideRoadTile\" is only intended to be instantiated through code")
    }
    
    override public func updateSize() {
        super.updateSize()
        
        road.texture = Texture.curvedWideRoad
        road.size = Texture.curvedWideRoad.size()
        let offset: CGFloat = 0.5 * Size.boardTile.width - 2 * Size.roadLaneWidth - 1.5 * Size.roadDividerWidth - 0.5 * Size.roadOutlineWidth
        road.position = CGPoint(x: 0.5 * offset, y: -0.5 * offset)
    }
}
