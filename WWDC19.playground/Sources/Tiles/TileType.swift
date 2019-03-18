import SpriteKit

public enum TileType: CaseIterable {
    
    case grass
    case straightRoad
    case straightWideRoad
    
    public var tile: Tile {
        get {
            switch self {
                case .grass: return GrassTile()
                case .straightRoad: return StraightRoadTile()
                case .straightWideRoad: return StraightWideRoadTile()
            }
        }
    }
}

