import SpriteKit

public struct RotateIconTextureGenerator {
    static func generate() -> SKTexture! {
        let arrowWidth: CGFloat = 0.04 * Size.boardTile.width
        let lineWidth: CGFloat = 0.01 * Size.boardTile.width
        
        let node = SKShapeNode()
        node.fillColor = SKColor(white: 0.8, alpha: 1)
        node.lineWidth = 0
        node.path = {
            let path = CGMutablePath()
            path.addArc(center: .zero,
                        radius: 0.1 * Size.boardTile.width + lineWidth,
                        startAngle: -0.7 * .pi,
                        endAngle: .pi,
                        clockwise: false)
            path.addLine(to: CGPoint(x: -0.1 * Size.boardTile.width - arrowWidth, y: 0))
            path.addLine(to: CGPoint(x: -0.1 * Size.boardTile.width, y: -arrowWidth))
            path.addLine(to: CGPoint(x: -0.1 * Size.boardTile.width + arrowWidth, y: 0))
            path.addArc(center: .zero,
                        radius: 0.1 * Size.boardTile.width - lineWidth,
                        startAngle: .pi,
                        endAngle: -0.7 * .pi,
                        clockwise: true)
            path.closeSubpath()
            return path
        }()
        
        return SKView().texture(from: node)
    }
}
