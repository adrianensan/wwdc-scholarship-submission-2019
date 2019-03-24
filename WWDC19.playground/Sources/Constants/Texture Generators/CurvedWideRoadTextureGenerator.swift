import SpriteKit

public struct CurvedWideRoadTextureGenerator {
    static func generate() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width,
                              height: 4 * Size.roadLaneWidth + 3 * Size.roadDividerWidth)
        
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
        
        let roadDividerSegmentNode = BaseShapeNodes.roadDivider
        roadDividerSegmentNode.path = {
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                        y: -0.5 * Size.boardTile.height),
                        radius: 0.5 * Size.boardTile.width,
                        startAngle: 0.5 * .pi,
                        endAngle: .pi,
                        clockwise: false)
            path.closeSubpath()
            return path
        }()
        node.addChild(roadDividerSegmentNode)
        
        let segmentsOuter = 5
        let segmentsOuterSpacing: CGFloat = 0.5 * .pi / CGFloat(segmentsOuter)
        let segmentOuterLength: CGFloat = 0.6 * segmentsOuterSpacing
        for i in 0..<segmentsOuter {
            let roadDividerSegmentNode = BaseShapeNodes.roadDivider
            roadDividerSegmentNode.path = {
                let path = CGMutablePath()
                path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                            y: -0.5 * Size.boardTile.height),
                            radius: 0.5 * (Size.boardTile.width - Size.roadDividerWidth) + 0.25 * roadSize.height + 0.5 * Size.roadDividerWidth,
                            startAngle: 0.5 * (.pi + (segmentsOuterSpacing - segmentOuterLength)) + CGFloat(i) * segmentsOuterSpacing,
                            endAngle: 0.5 * (.pi + (segmentsOuterSpacing - segmentOuterLength)) + CGFloat(i) * segmentsOuterSpacing + segmentOuterLength,
                            clockwise: false)
                path.closeSubpath()
                return path
            }()
            node.addChild(roadDividerSegmentNode)
        }
        
        let segmentsInner = 2
        let segmentsInnerSpacing: CGFloat = 0.5 * .pi / CGFloat(segmentsInner)
        let segmentInnerLength: CGFloat = 0.6 * segmentsInnerSpacing
        for i in 0..<segmentsInner {
            let roadDividerSegmentNode = BaseShapeNodes.roadDivider
            roadDividerSegmentNode.path = {
                let path = CGMutablePath()
                path.addArc(center: CGPoint(x: 0.5 * Size.boardTile.width,
                                            y: -0.5 * Size.boardTile.height),
                            radius: 0.5 * (Size.boardTile.width - Size.roadDividerWidth) - 0.25 * roadSize.height - 0.5 * Size.roadDividerWidth,
                            startAngle: 0.5 * (.pi + (segmentsInnerSpacing - segmentInnerLength)) + CGFloat(i) * segmentsInnerSpacing,
                            endAngle: 0.5 * (.pi + (segmentsInnerSpacing - segmentInnerLength)) + CGFloat(i) * segmentsInnerSpacing + segmentInnerLength,
                            clockwise: false)
                path.closeSubpath()
                return path
            }()
            node.addChild(roadDividerSegmentNode)
        }
        
        return SKView().texture(from: node)
    }
}
