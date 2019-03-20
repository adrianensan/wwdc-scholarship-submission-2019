import SpriteKit

public struct StraightRoadTextureGenerator {
    static func generate() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width,
                              height: 2 * Size.roadLaneWidth + Size.roadDividerWidth)
        
        let node = SKNode()
        
        let roadNode = SKShapeNode()
        roadNode.fillColor = Color.road
        roadNode.lineWidth = 0
        roadNode.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: roadSize.offset,
                                size: roadSize))
            path.closeSubpath()
            return path
        }()
        roadNode.zPosition = 1
        node.addChild(roadNode)
        
        let segments = 4
        let segmentsSpacing: CGFloat = roadSize.width / CGFloat(segments)
        let segmentLength: CGFloat = 0.6 * segmentsSpacing
        for i in 0..<segments {
            let roadDividerSegmentNode = SKShapeNode()
            roadDividerSegmentNode.fillColor = Color.roadDivider
            roadDividerSegmentNode.lineWidth = 0
            roadDividerSegmentNode.path = {
                let path = CGMutablePath()
                path.addRoundedRect(in: CGRect(origin: CGPoint(x: -0.5 * (roadSize.width - segmentsSpacing + segmentLength) + CGFloat(i) * segmentsSpacing,
                                                               y: -0.5 * Size.roadDividerWidth),
                                               size: CGSize(width: segmentLength, height: Size.roadDividerWidth)),
                                    cornerWidth: 0.5 * Size.roadDividerWidth,
                                    cornerHeight: 0.5 * Size.roadDividerWidth)
                path.closeSubpath()
                return path
            }()
            roadDividerSegmentNode.zPosition = 2
            node.addChild(roadDividerSegmentNode)
        }
        
        return SKView().texture(from: node)
    }

}
