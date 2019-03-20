import SpriteKit

public enum TileType: CaseIterable {
    
    case grass
    case straightRoad
    case straightWideRoad
    case narrowToWideRoad
    case curvedWideRoad
    case curvedRoad
    
    public var tile: Tile {
        get {
            switch self {
            case .grass: return GrassTile()
            case .straightRoad: return StraightRoadTile()
            case .straightWideRoad: return StraightWideRoadTile()
            case .narrowToWideRoad: return NarrowToWideRoadTile()
            case .curvedRoad: return CurvedRoadTile()
            case .curvedWideRoad: return CurvedWideRoadTile()
            }
        }
    }
}

