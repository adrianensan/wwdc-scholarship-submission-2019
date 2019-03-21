import SpriteKit

public struct StraightWideRoadTextureGenerator {
    static func generate() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width,
                              height: 4 * Size.roadLaneWidth + 3 * Size.roadDividerWidth)
        
        let node = SKNode()
        
        let roadNode = BaseShapeNodes.roadFill
        roadNode.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: roadSize.offset,
                                size: roadSize))
            path.closeSubpath()
            return path
        }()
        node.addChild(roadNode)
        
        let roadNodeOutline = BaseShapeNodes.roadOutline
        roadNodeOutline.path = {
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: roadSize.offset.x, y: roadSize.offset.y),
                CGPoint(x: roadSize.offset.x + roadSize.width, y: roadSize.offset.y),
            ])
            path.addLines(between: [
                CGPoint(x: roadSize.offset.x, y: roadSize.offset.y + roadSize.height),
                CGPoint(x: roadSize.offset.x + roadSize.width, y: roadSize.offset.y + roadSize.height),
            ])
            return path
        }()
        node.addChild(roadNodeOutline)
        
        let segments = 4
        let segmentsSpacing: CGFloat = roadSize.width / CGFloat(segments)
        let segmentLength: CGFloat = 0.6 * segmentsSpacing
        
        // Solid Line
        let roadDividerSegmentNode = BaseShapeNodes.roadDivider
        roadDividerSegmentNode.path = {
            let path = CGMutablePath()
            path.addRoundedRect(in: CGRect(origin: CGPoint(x: -0.5 * roadSize.width,
                                                           y: -0.5 * Size.roadDividerWidth),
                                           size: CGSize(width: roadSize.width, height: Size.roadDividerWidth)),
                                cornerWidth: 0.25 * Size.roadDividerWidth,
                                cornerHeight: 0.25 * Size.roadDividerWidth)
            path.closeSubpath()
            return path
        }()
        node.addChild(roadDividerSegmentNode)
        
        for i in 0..<2 {
            for j in 0..<segments {
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
