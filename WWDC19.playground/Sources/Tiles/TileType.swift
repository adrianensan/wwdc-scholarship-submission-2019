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
    
    public func closestRoadPoint(point: CGPoint, direction: CGFloat, tileRotation: CGFloat) -> CGPoint? {
        switch self {
        case .grass: return nil
        case .straightRoad: return .zero
        case .straightWideRoad: return .zero
        case .narrowToWideRoad: return .zero
        case .curvedRoad: return .zero
        case .curvedWideRoad: return .zero
        }
    }
}

