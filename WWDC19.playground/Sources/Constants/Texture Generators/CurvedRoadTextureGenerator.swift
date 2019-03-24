import SpriteKit

public struct CurvedRoadTextureGenerator {
    static func generate() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width,
                              height: 2 * Size.roadLaneWidth + Size.roadDividerWidth)
        
        let node = SKNode()
        
        let roadNode = BaseShapeNodes.roadFill
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
        node.addChild(roadNode)
        
        let roadNodeOutline = BaseShapeNodes.roadOutline
        roadNodeOutline.path = {
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                        y: -0.5 * Size.boardTile.height),
                        radius: 0.5 * (Size.boardTile.width + roadSize.height),
                        startAngle: 0.5 * .pi,
                        endAngle: .pi,
                        clockwise: false)
            path.move(to: CGPoint(x: 0.5 * Size.boardTile.width,
                                  y: -0.5 * Size.boardTile.height + 0.5 * (Size.boardTile.height - roadSize.height)))
            path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                        y: -0.5 * Size.boardTile.height),
                        radius: 0.5 * (Size.boardTile.width - roadSize.height),
                        startAngle: 0.5 * .pi,
                        endAngle: .pi,
                        clockwise: false)
            return path
        }()
        node.addChild(roadNodeOutline)
        
        let segments = 3
        let segmentsSpacing: CGFloat = 0.5 * .pi / CGFloat(segments)
        let segmentLength: CGFloat = 0.6 * segmentsSpacing
        for i in 0..<segments {
            let roadDividerSegmentNode = BaseShapeNodes.roadDivider
            roadDividerSegmentNode.path = {
                let path = CGMutablePath()
                path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                            y: -0.5 * Size.boardTile.height),
                            radius: 0.5 * Size.boardTile.width,
                            startAngle: 0.5 * (.pi + (segmentsSpacing - segmentLength)) + CGFloat(i) * segmentsSpacing,
                            endAngle: 0.5 * (.pi + (segmentsSpacing - segmentLength)) + CGFloat(i) * segmentsSpacing + segmentLength,
                            clockwise: false)
                path.closeSubpath()
                return path
            }()
            node.addChild(roadDividerSegmentNode)
        }
        
        return SKView().texture(from: node)
    }
}
