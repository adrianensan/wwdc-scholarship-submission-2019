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
    
    public func closestRoadPoint(point: CGPoint,
                                 direction: CGFloat,
                                 tilePosition: CGPoint,
                                 tileRotation: CGFloat) -> CGPoint? {
        var targetPoint = CGPoint()
        switch self {
        case .grass: return nil
        case .straightRoad:
            targetPoint = straightRoadCheck(lane: 0.5 * (Size.roadLaneWidth + Size.roadDividerWidth),
                                            point: point,
                                            direction: direction,
                                            tilePosition: tilePosition,
                                            tileRotation: tileRotation)
        case .straightWideRoad:
            targetPoint = straightRoadCheck(lane: 1.5 * (Size.roadLaneWidth + Size.roadDividerWidth),
                                            point: point,
                                            direction: direction,
                                            tilePosition: tilePosition,
                                            tileRotation: tileRotation)
        case .narrowToWideRoad: return .zero
        case .curvedRoad:
            let distFromCenter: CGFloat = 0.5 * (Size.roadLaneWidth + Size.roadDividerWidth)
            targetPoint = curveRoadCheck(lane: distFromCenter,
                                         point: point,
                                         direction: direction,
                                         tilePosition: tilePosition,
                                         tileRotation: tileRotation)
        case .curvedWideRoad:
            let distFromCenter: CGFloat = 1.5 * (Size.roadLaneWidth + Size.roadDividerWidth)
            targetPoint = curveRoadCheck(lane: distFromCenter,
                                         point: point,
                                         direction: direction,
                                         tilePosition: tilePosition,
                                         tileRotation: tileRotation)
        }
        
        return targetPoint
    }
    
    public func straightRoadCheck(lane: CGFloat,
                                  point: CGPoint,
                                  direction: CGFloat,
                                  tilePosition: CGPoint,
                                  tileRotation: CGFloat) -> CGPoint {
        var targetPoint = CGPoint()
        let isHorizontal = tileRotation.remainder(dividingBy: .pi) == 0
        let point1 = isHorizontal ? \CGPoint.x : \CGPoint.y
        let point2 = isHorizontal ? \CGPoint.y : \CGPoint.x
        targetPoint[keyPath: point1] = point[keyPath: point1]
        if abs(CGFloat.shortestAngle(from: direction, to: isHorizontal ? 0 : 0.5 * .pi)) < 0.5 * .pi {
            targetPoint[keyPath: point2] = tilePosition[keyPath: point2] + (isHorizontal ? -lane : lane)
            targetPoint[keyPath: point1] += 0.5 * Size.carHeight
        }
        else {
            targetPoint[keyPath: point2] = tilePosition[keyPath: point2] + (isHorizontal ? lane : -lane)
            targetPoint[keyPath: point1] -= 0.5 * Size.carHeight
        }
        return targetPoint
    }
    
    public func curveRoadCheck(lane: CGFloat,
                               point: CGPoint,
                               direction: CGFloat,
                               tilePosition: CGPoint,
                               tileRotation: CGFloat) -> CGPoint {
        var targetPoint = CGPoint()
        
        let roadCurveCenter = tilePosition + (0.5 * Size.boardTile.diagonal).inDirectionOf(rotation: -0.25 * .pi + tileRotation)
        var angle = roadCurveCenter.angle(to: point)
        if abs(CGFloat.shortestAngle(from: direction, to: angle + 0.5 * .pi)) < 0.5 * .pi {
            angle += 0.05
            targetPoint.x = roadCurveCenter.x + (0.5 * Size.boardTile.width + lane).inDirectionOf(rotation: angle).x
            targetPoint.y = roadCurveCenter.y + (0.5 * Size.boardTile.width + lane).inDirectionOf(rotation: angle).y
        }
        else {
            angle -= 0.05
            targetPoint.x = roadCurveCenter.x + (0.5 * Size.boardTile.width - lane).inDirectionOf(rotation: angle).x
            targetPoint.y = roadCurveCenter.y + (0.5 * Size.boardTile.width - lane).inDirectionOf(rotation: angle).y
        }
        return targetPoint
    }
}

