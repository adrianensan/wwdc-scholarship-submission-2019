import SpriteKit

public class Sidebar: SKNode {
    
    let background: SKSpriteNode
    var tileSelector: TileSelector
    
    var editBoardButton: SKLabelNode
    
    var delegate: NewTileDelegate? {
        get { return tileSelector.delegate }
        set { tileSelector.delegate = newValue }
    }
    
    var editingBoard: Bool {
        didSet {
            updatePositioning()
        }
    }
    
    public override init() {
        background = SKSpriteNode()
        tileSelector = TileSelector()
        editBoardButton = SKLabelNode()
        editingBoard = false
        super.init()
        
        background.color = SKColor(white: 0, alpha: 0.75)
        background.zPosition = ZPosition.overlay
        addChild(background)
        
        addChild(tileSelector)
        
        editBoardButton.text = "Edit Board"
        editBoardButton.fontName = Constant.font
        editBoardButton.verticalAlignmentMode = .center
        editBoardButton.isUserInteractionEnabled = true
        background.addChild(editBoardButton)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"TileSelector\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        let longSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.height : \CGSize.width
        let shortSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.width : \CGSize.height
        
        background.size[keyPath: shortSide] = 2.75 * Size.boardTile[keyPath: shortSide]
        background.size[keyPath: longSide] = Size.sceneSize[keyPath: longSide]
        
        tileSelector.updateSize()
        
        editBoardButton.fontSize = Size.secondaryFontSize
        updatePositioning()
    }
    
    public func update(_ currentTime: TimeInterval) {
        
    }
    
    private func updatePositioning(animate: Bool = false) {
        let longSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.height : \CGSize.width
        let shortSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.width : \CGSize.height
        let point1 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.x : \CGPoint.y
        let point2 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.y : \CGPoint.x
        
        let offset: CGFloat = (editingBoard ? -0.5 : 0.25) * background.size[keyPath: shortSide]
        
        var targetPosition: CGPoint = .zero
        targetPosition[keyPath: point1] = 0.5 * Size.sceneSize[keyPath: shortSide] + offset
        targetPosition[keyPath: point2] = 0
        background.run(.move(to: targetPosition, duration: Duration.magnetSnapAnimation))
        
        var tileSelectorTargetPosition: CGPoint = .zero
        tileSelectorTargetPosition[keyPath: point1] = (editingBoard ? 0 : 0.5) * background.size[keyPath: shortSide]
        tileSelectorTargetPosition[keyPath: point2] = 0
        tileSelector.run(.group([
            .move(to: tileSelectorTargetPosition, duration: Duration.magnetSnapAnimation),
            .fadeAlpha(to: editingBoard ? 1 : 0, duration: Duration.magnetSnapAnimation)
        ]))
        
        editBoardButton.position[keyPath: point1] = -0.5 * background.size[keyPath: shortSide]
        editBoardButton.position[keyPath: point2] = (Size.sceneSize.width > Size.sceneSize.height ? 0.4 : -0.4) * Size.sceneSize[keyPath: longSide]
        
    }
}
