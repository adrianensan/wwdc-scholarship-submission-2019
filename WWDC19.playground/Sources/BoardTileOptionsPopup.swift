import SpriteKit

public class BoardTileOptionsPopup: SKNode {
    
    var tile: Tile? {
        didSet {
            if let tile = tile {
                if alpha != 0 {
                    run(.group([
                        .fadeAlpha(to: 1, duration: 0.5 * Duration.magnetSnapAnimation),
                        .move(to: CGPoint(x: tile.position.x,
                                          y: tile.position.y + 0.8 * Size.boardTile.height),
                              duration: 0.5 * Duration.magnetSnapAnimation)
                    ]))
                }
                else {
                    position.x = tile.position.x
                    position.y = tile.position.y + 0.8 * Size.boardTile.height
                    run(.fadeAlpha(to: 1, duration: 0.5 * Duration.magnetSnapAnimation))
                }
            }
            else { run(.fadeAlpha(to: 0, duration: 0.5 * Duration.magnetSnapAnimation)) }
        }
    }
    
    private let background: SKSpriteNode
    private let rotateIconLeft: SKSpriteNode
    private let rotateIconRight: SKSpriteNode
    
    override public init() {
        background = SKSpriteNode()
        rotateIconLeft = SKSpriteNode()
        rotateIconRight = SKSpriteNode()
        super.init()
        
        alpha = 0
        isUserInteractionEnabled = true
        
        background.color = .black
        background.zPosition = ZPosition.overlay
        addChild(background)
        
        rotateIconLeft.zPosition = ZPosition.overlayTile
        addChild(rotateIconLeft)
        
        rotateIconRight.zPosition = ZPosition.overlayTile
        rotateIconRight.xScale = -1
        addChild(rotateIconRight)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Tile\" is only intended to be instantiated through code")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.location(in: self).x < 0 {
                tile?.run(.rotate(byAngle: 0.5 * .pi, duration: Duration.magnetSnapAnimation),
                          timingMode: .easeInEaseOut)
            }
            else {
                tile?.run(.rotate(byAngle: -0.5 * .pi, duration: Duration.magnetSnapAnimation),
                          timingMode: .easeInEaseOut)
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    public func updateSize() {
        background.texture = Texture.tileOptionsPopup
        background.size = Texture.tileOptionsPopup.size()
        
        rotateIconLeft.texture = Texture.rotateIcon
        rotateIconLeft.size = Texture.rotateIcon.size()
        rotateIconLeft.position.x = -0.25 * Size.boardTile.width
        
        rotateIconRight.texture = Texture.rotateIcon
        rotateIconRight.size = Texture.rotateIcon.size()
        rotateIconRight.position.x = 0.25 * Size.boardTile.width
    }
    
    public func update(_ delta: CGFloat) {
    }
}
