import SpriteKit

public enum TileType: CaseIterable {
    
    case grass
    case straightRoad
    case straightWideRoad
    case narrowToWideRoad
    
    public var tile: Tile {
        get {
            switch self {
            case .grass: return GrassTile()
            case .straightRoad: return StraightRoadTile()
            case .straightWideRoad: return StraightWideRoadTile()
            case .narrowToWideRoad: return NarrowToWideRoadTile()
            }
        }
    }
}

