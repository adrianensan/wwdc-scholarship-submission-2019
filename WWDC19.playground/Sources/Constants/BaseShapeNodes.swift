import SpriteKit

public struct BaseShapeNodes {
    
    static var roadFill: SKShapeNode {
        let node = SKShapeNode()
        node.fillColor = Color.road
        node.lineWidth = 0
        node.zPosition = 1
        return node
    }
    
    static var roadOutline: SKShapeNode {
        let node = SKShapeNode()
        node.fillColor = .clear
        node.lineWidth = Size.roadOutlineWidth
        node.strokeColor = .black
        node.zPosition = 0
        return node
    }
    
    static var roadDivider: SKShapeNode {
        let node = SKShapeNode()
        node.fillColor = Color.roadDivider
        node.lineWidth = 0
        node.zPosition = 2
        return node
    }
    
}
