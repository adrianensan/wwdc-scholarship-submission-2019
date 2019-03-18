import SpriteKit

public class Background: SKNode {
    
    private var woodBlocks: [SKSpriteNode]
    
    public override init() {
        woodBlocks = [SKSpriteNode]()
        super.init()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"PlaceholderTile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        for woodBlock in woodBlocks { woodBlock.removeFromParent() }
        woodBlocks.removeAll()
        
        let woodBlocksPerRow = Int(ceil(Size.sceneSize.width / Size.backgroundWoodBlock.width)) + 1
        let spacing = Size.backgroundWoodBlock + 0.02 * Size.backgroundWoodBlock.height
        
        var yPosition: CGFloat = -0.5 * Size.sceneSize.height
        var previousXStartOffset: CGFloat = -0.5 * Size.sceneSize.width
        while yPosition < 0.5 * Size.sceneSize.height + Size.backgroundWoodBlock.height {
            var xPosition: CGFloat = 0
            repeat {
                xPosition = -0.5 * Size.sceneSize.width + CGFloat.random(in: 0..<(0.5 * Size.backgroundWoodBlock.width))
            } while abs(previousXStartOffset - xPosition) < 0.2 * Size.backgroundWoodBlock.width
            previousXStartOffset = xPosition
            for _ in 0..<woodBlocksPerRow {
                let woodBlock = SKSpriteNode()
                woodBlock.size = Size.backgroundWoodBlock
                woodBlock.color = Color.backgroundWoodBlock
                woodBlock.alpha = 1 - CGFloat.random(in: 0..<0.2)
                woodBlock.position = CGPoint(x: xPosition, y: yPosition)
                addChild(woodBlock)
                woodBlocks.append(woodBlock)
                xPosition += spacing.width
            }
            yPosition += spacing.height
        }
    }
    
    public func update(_ delta: CGFloat) {
        //alpha += flashingDirection
        //if alpha >= 1 || alpha <= 0.8 {
        //    flashingDirection *= -1
        // }
    }
}
