import SpriteKit

public struct StraightRoadTextureGenerator {
    static func generate() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width,
                              height: 2 * Size.roadLaneWidth + Size.roadDividerWidth)
        
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
            path.closeSubpath()
            return path
        }()
        node.addChild(roadNodeOutline)
        
        let segments = 4
        let segmentsSpacing: CGFloat = roadSize.width / CGFloat(segments)
        let segmentLength: CGFloat = 0.6 * segmentsSpacing
        for i in 0..<segments {
            let roadDividerSegmentNode = BaseShapeNodes.roadDivider
            roadDividerSegmentNode.fillColor = .clear
            roadDividerSegmentNode.strokeColor = Color.roadDivider
            roadDividerSegmentNode.lineWidth = Size.roadDividerWidth
            roadDividerSegmentNode.path = {
                let path = CGMutablePath()
                path.addLines(between: [
                    CGPoint(x: -0.5 * (roadSize.width - segmentsSpacing + segmentLength) + CGFloat(i) * segmentsSpacing, y: 0),
                    CGPoint(x: -0.5 * (roadSize.width - segmentsSpacing + segmentLength) + CGFloat(i) * segmentsSpacing + segmentLength, y: 0)
                ])
                return path
            }()
            node.addChild(roadDividerSegmentNode)
        }
        
        return SKView().texture(from: node)
    }
}
