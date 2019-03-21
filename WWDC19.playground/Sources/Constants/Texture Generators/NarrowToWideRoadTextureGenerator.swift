import SpriteKit

public struct NarrowToWideRoadTextureGenerator {
    static func generate() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width,
                              height: 4 * Size.roadLaneWidth + 3 * Size.roadDividerWidth)
        let bigHalfHeight: CGFloat = 2 * Size.roadLaneWidth + 1.5 * Size.roadDividerWidth
        let smallHalfHeight: CGFloat = Size.roadLaneWidth + 0.5 * Size.roadDividerWidth
        
        let node = SKNode()
        
        let roadNode = BaseShapeNodes.roadFill
        roadNode.path = {
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: -0.5 * Size.boardTile.width, y: -bigHalfHeight),
                CGPoint(x: -0.3 * Size.boardTile.width, y: -bigHalfHeight),
                CGPoint(x: 0.3 * Size.boardTile.width, y: -smallHalfHeight),
                CGPoint(x: 0.5 * Size.boardTile.width, y: -smallHalfHeight),
                CGPoint(x: 0.5 * Size.boardTile.width, y: smallHalfHeight),
                CGPoint(x: 0.3 * Size.boardTile.width, y: smallHalfHeight),
                CGPoint(x: -0.3 * Size.boardTile.width, y: bigHalfHeight),
                CGPoint(x: -0.5 * Size.boardTile.width, y: bigHalfHeight)
            ])
            path.closeSubpath()
            return path
        }()
        node.addChild(roadNode)
        
        let roadNodeOutline = BaseShapeNodes.roadOutline
        roadNodeOutline.path = {
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: -0.5 * Size.boardTile.width, y: -bigHalfHeight),
                CGPoint(x: -0.3 * Size.boardTile.width, y: -bigHalfHeight),
                CGPoint(x: 0.3 * Size.boardTile.width, y: -smallHalfHeight),
                CGPoint(x: 0.5 * Size.boardTile.width, y: -smallHalfHeight)
            ])
            path.addLines(between: [
                CGPoint(x: 0.5 * Size.boardTile.width, y: smallHalfHeight),
                CGPoint(x: 0.3 * Size.boardTile.width, y: smallHalfHeight),
                CGPoint(x: -0.3 * Size.boardTile.width, y: bigHalfHeight),
                CGPoint(x: -0.5 * Size.boardTile.width, y: bigHalfHeight)
            ])
            return path
        }()
        node.addChild(roadNodeOutline)
        
        let segments = 4
        let segmentsSpacing: CGFloat = roadSize.width / CGFloat(segments)
        let segmentLength: CGFloat = 0.6 * segmentsSpacing
        
        // Center Dashed line
        let roadDividerSegmentNode = BaseShapeNodes.roadDivider
        roadDividerSegmentNode.path = {
            let path = CGMutablePath()
            path.addRoundedRect(in: CGRect(origin: CGPoint(x: -0.5 * (roadSize.width - segmentsSpacing + segmentLength) + 3 * segmentsSpacing,
                                                           y: -0.5 * Size.roadDividerWidth),
                                           size: CGSize(width: segmentLength, height: Size.roadDividerWidth)),
                                cornerWidth: 0.5 * Size.roadDividerWidth,
                                cornerHeight: 0.5 * Size.roadDividerWidth)
            path.closeSubpath()
            return path
        }()
        node.addChild(roadDividerSegmentNode)
        
        // Solid Line
        let roadSolidDividerSegmentNode = BaseShapeNodes.roadDivider
        roadSolidDividerSegmentNode.path = {
            let path = CGMutablePath()
            path.addRoundedRect(in: CGRect(origin: CGPoint(x: -0.5 * roadSize.width,
                                                           y: -0.5 * Size.roadDividerWidth),
                                           size: CGSize(width: roadSize.width - segmentsSpacing - 0.5 * (segmentsSpacing - segmentLength), height: Size.roadDividerWidth)),
                                cornerWidth: 0.25 * Size.roadDividerWidth,
                                cornerHeight: 0.25 * Size.roadDividerWidth)
            path.closeSubpath()
            return path
        }()
        node.addChild(roadSolidDividerSegmentNode)
        
        for i in 0..<2 {
            for j in 0..<1 {
                let roadDividerSegmentNode = BaseShapeNodes.roadDivider
                roadDividerSegmentNode.path = {
                    let path = CGMutablePath()
                    path.addRoundedRect(in: CGRect(origin: CGPoint(x: -0.5 * (roadSize.width - segmentsSpacing + segmentLength) + CGFloat(j) * segmentsSpacing,
                                                                   y: -Size.roadLaneWidth - 1.5 *  Size.roadDividerWidth + CGFloat(i) * 2 * (Size.roadLaneWidth + Size.roadDividerWidth)),
                                                   size: CGSize(width: segmentLength, height: Size.roadDividerWidth)),
                                        cornerWidth: 0.5 * Size.roadDividerWidth,
                                        cornerHeight: 0.5 * Size.roadDividerWidth)
                    path.closeSubpath()
                    return path
                }()
                node.addChild(roadDividerSegmentNode)
            }
        }
        
        return SKView().texture(from: node)
    }
}
