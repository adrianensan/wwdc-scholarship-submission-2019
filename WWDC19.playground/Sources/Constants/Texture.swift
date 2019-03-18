import SpriteKit

public struct Texture {
    
    static var placeholderTile: SKTexture!
    static var car: SKTexture!
    
    // Tiles
    static var tileShadow: SKTexture!
    static var grassTile: SKTexture!
    static var straightRoad: SKTexture!
    static var straightWideRoad: SKTexture!
    
    static var grassAccent: SKTexture!
    
    static func regenerateTextures() {
        placeholderTile = generatePlaceholderTileTexture()
        car = generateCarTexture()
        
        tileShadow = generateTileShadowTexture()
        grassTile = generateGrassTileTexture()
        straightRoad = generateStraightRoadTexture()
        straightWideRoad = generateStraightWideRoadTexture()
        
        grassAccent = generateGrassTileAccentTexture()
    }
    
    static private func generateGrassTileTexture() -> SKTexture! {
        let node = SKNode()
        
        let tileBase = SKShapeNode()
        tileBase.fillColor = Color.grass
        tileBase.lineWidth = 0
        tileBase.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: Size.boardTile.offset,
                                size: Size.boardTile))
            path.closeSubpath()
            return path
        }()
        node.addChild(tileBase)
        
        return SKView().texture(from: node)
    }
    
    static private func generateStraightRoadTexture() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width, height: 2 * Size.roadLaneWidth + Size.roadDividerWidth)
        
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
    
    static private func generateStraightWideRoadTexture() -> SKTexture! {
        let roadSize = CGSize(width: Size.boardTile.width, height: 4 * Size.roadLaneWidth + 3 * Size.roadDividerWidth)
        
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
        
        // Solid Line
        let roadDividerSegmentNode = SKShapeNode()
        roadDividerSegmentNode.fillColor = Color.roadDivider
        roadDividerSegmentNode.lineWidth = 0
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
        roadDividerSegmentNode.zPosition = 2
        node.addChild(roadDividerSegmentNode)
        
        for i in 0..<2 {
            for j in 0..<segments {
                let roadDividerSegmentNode = SKShapeNode()
                roadDividerSegmentNode.fillColor = Color.roadDivider
                roadDividerSegmentNode.lineWidth = 0
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
                roadDividerSegmentNode.zPosition = 2
                node.addChild(roadDividerSegmentNode)
            }
        }
        
        return SKView().texture(from: node)
    }
    
    static private func generateGrassTileAccentTexture() -> SKTexture! {
        let width: CGFloat = CGFloat.random(in: 0.03..<0.05) * Size.boardTile.width
        let height: CGFloat = CGFloat.random(in: 0.05..<0.075) * Size.boardTile.height
        
        let node = SKNode()
        
        let tileBase = SKShapeNode()
        tileBase.fillColor = Color.grassAccent
        tileBase.lineWidth = 0
        tileBase.path = {
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: -0.5 * width, y: -0.5 * height),
                CGPoint(x: -0, y: 0.5 * height),
                CGPoint(x: 0.5 * width, y: -0.5 * height)
            ])
            path.closeSubpath()
            return path
        }()
        node.addChild(tileBase)
        
        return SKView().texture(from: node)
    }
    
    static private func generatePlaceholderTileTexture() -> SKTexture! {
        let node = SKNode()
        
        let clipNodeMask = SKShapeNode()
        clipNodeMask.fillColor = .black
        clipNodeMask.lineWidth = 0
        clipNodeMask.lineJoin = .round
        clipNodeMask.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: CGSize(width: 0.95 * Size.boardTile.width,
                                               height: 0.95 * Size.boardTile.height).offset,
                                size: CGSize(width: 0.97 * Size.boardTile.width,
                                             height: 0.97 * Size.boardTile.height)))
            path.closeSubpath()
            return path
        }()
        
        let clipNode = SKCropNode()
        clipNode.maskNode = clipNodeMask
        
        let borderShape = SKShapeNode()
        borderShape.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        borderShape.strokeColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        borderShape.lineWidth = 0.06 * Size.boardTile.width
        borderShape.lineJoin = .round
        borderShape.glowWidth = 0.075 * Size.boardTile.width
        borderShape.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: Size.boardTile.offset,
                                size: Size.boardTile))
            path.closeSubpath()
            return path
        }()
        node.addChild(borderShape)
        
        clipNode.addChild(node)
        
        return SKView().texture(from: clipNode,
                                crop: CGRect(origin: clipNode.calculateAccumulatedFrame().originOffsetFromCenter(offset: Size.boardTile),
                                             size: Size.boardTile))
    }
    
    static private func generateTileShadowTexture() -> SKTexture! {
        let node = SKNode()
        
        let borderShape = SKShapeNode()
        borderShape.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        borderShape.strokeColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        borderShape.lineWidth = 0.025 * Size.boardTile.width
        borderShape.lineJoin = .round
        borderShape.glowWidth = 0.025 * Size.boardTile.width
        borderShape.path = {
            let path = CGMutablePath()
            path.addRect(CGRect(origin: Size.boardTile.offset,
                                size: Size.boardTile))
            path.closeSubpath()
            return path
        }()
        node.addChild(borderShape)
        
        return SKView().texture(from: node)
    }

    
    static private func generateCarTexture() -> SKTexture! {
        let width: CGFloat = 80
        let halfWidth: CGFloat = 0.5 * width
        
        //let height: CGFloat = 200
        let halfHeight: CGFloat = 0.5 * width
        
        let carNode = SKNode()
        
        for i in 0..<4 {
            let wheel = SKSpriteNode()
            wheel.size = CGSize(width: 0.25 * width,
                                height: 0.15 * width)
            wheel.color = .black
            wheel.position.x = CGFloat(i < 2 ? 1 : -1) * halfWidth
            wheel.position.y = CGFloat(i % 2 == 0 ? 1 : -1) * 0.5 * halfHeight
            carNode.addChild(wheel)
        }
        
        let baseCarShape = SKShapeNode()
        baseCarShape.fillColor = .red
        baseCarShape.strokeColor = .red
        baseCarShape.lineWidth = 0.1 * width
        baseCarShape.lineJoin = .round
        baseCarShape.path = {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -halfWidth, y: -0.8 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: halfWidth, y: -0.8 * halfHeight),
                              control: CGPoint(x: 0, y: -halfHeight))
            path.addLine(to: CGPoint(x: halfWidth, y: 0.7 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: -halfWidth, y: 0.7 * halfHeight),
                              control: CGPoint(x: 0, y: halfHeight))
            path.closeSubpath()
            return path
        }()
        carNode.addChild(baseCarShape)
        
        let frontWindowShape = SKShapeNode()
        frontWindowShape.fillColor = .black
        frontWindowShape.strokeColor = .black
        frontWindowShape.lineWidth = 0.1 * width
        frontWindowShape.lineJoin = .round
        frontWindowShape.path = {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -0.8 * halfWidth, y: 0.25 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: 0.8 * halfWidth, y: 0.25 * halfHeight),
                              control: CGPoint(x: 0, y: 0.35 * halfHeight))
            path.addLine(to: CGPoint(x: 0.9 * halfWidth, y: 0.4 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: -0.9 * halfWidth, y: 0.4 * halfHeight),
                              control: CGPoint(x: 0, y: 0.6 * halfHeight))
            path.closeSubpath()
            return path
        }()
        carNode.addChild(frontWindowShape)
        
        let backWindowShape = SKShapeNode()
        backWindowShape.fillColor = .black
        backWindowShape.strokeColor = .black
        backWindowShape.lineWidth = 0.1 * width
        backWindowShape.lineJoin = .round
        backWindowShape.path = {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -0.8 * halfWidth, y: -0.6 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: 0.8 * halfWidth, y: -0.6 * halfHeight),
                              control: CGPoint(x: 0, y: -0.8 * halfHeight))
            path.addLine(to: CGPoint(x: 0.8 * halfWidth, y: -0.55 * halfHeight))
            path.addQuadCurve(to: CGPoint(x: -0.8 * halfWidth, y: -0.55 * halfHeight),
                              control: CGPoint(x: 0, y: -0.65 * halfHeight))
            path.closeSubpath()
            return path
        }()
        carNode.addChild(backWindowShape)
        
        return SKView().texture(from: carNode)
    }
}

