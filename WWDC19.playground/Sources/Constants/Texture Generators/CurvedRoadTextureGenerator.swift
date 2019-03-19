import SpriteKit

public struct CurvedRoadTextureGenerator {
    static func generate() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width, height: 2 * Size.roadLaneWidth + Size.roadDividerWidth)
        
        let node = SKNode()
        
        let roadNode = SKShapeNode()
        roadNode.fillColor = Color.road
        roadNode.lineWidth = 0
        roadNode.path = {
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                        y: -0.5 * Size.boardTile.height),
                        radius: 0.5 * (Size.boardTile.width + roadSize.height),
                        startAngle: 0.5 * .pi,
                        endAngle: .pi,
                        clockwise: false)
            path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                        y: -0.5 * Size.boardTile.height),
                        radius: 0.5 * (Size.boardTile.width - roadSize.height),
                        startAngle: .pi,
                        endAngle: 0.5 * .pi,
                        clockwise: true)
            path.closeSubpath()
            return path
        }()
        roadNode.zPosition = 1
        node.addChild(roadNode)
        
        let segments = 3
        let segmentsSpacing: CGFloat = 0.5 * .pi / CGFloat(segments)
        let segmentLength: CGFloat = 0.6 * segmentsSpacing
        for i in 0..<segments {
            let roadDividerSegmentNode = SKShapeNode()
            roadDividerSegmentNode.fillColor = .clear
            roadDividerSegmentNode.lineWidth = Size.roadDividerWidth
            roadDividerSegmentNode.strokeColor = Color.roadDivider
            roadDividerSegmentNode.path = {
                let path = CGMutablePath()
                path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                            y: -0.5 * Size.boardTile.height),
                            radius: 0.5 * (Size.boardTile.width - Size.roadDividerWidth),
                            startAngle: 0.5 * (.pi + (segmentsSpacing - segmentLength)) + CGFloat(i) * segmentsSpacing,
                            endAngle: 0.5 * (.pi + (segmentsSpacing - segmentLength)) + CGFloat(i) * segmentsSpacing + segmentLength,
                            clockwise: false)
                path.closeSubpath()
                return path
            }()
            roadDividerSegmentNode.zPosition = 2
            node.addChild(roadDividerSegmentNode)
        }
        
        return SKView().texture(from: node)
    }
}
