import SpriteKit

public class TitleScreen: SKNode {
    
    var delegate: ButtonDelegate? {
        get { return startCreateButton.delegate }
        set {
            startCreateButton.delegate = newValue
            startDemoButton.delegate = newValue
        }
    }
    
    var background: SKSpriteNode
    var titleLabel: SKLabelNode
    
    private var startCreateButton: Button
    private var startDemoButton: Button
    
    override public init() {
        background = SKSpriteNode()
        titleLabel = SKLabelNode()
        
        startCreateButton = Button(id: ID.startCreateButton)
        startDemoButton = Button(id: ID.startDemoButton)
        super.init()
        
        background.color = .black
        background.zPosition = ZPosition.titleScreenBackground
        addChild(background)
        
        titleLabel.text = "Cars"
        titleLabel.fontColor = .white
        titleLabel.fontName = Constant.font
        titleLabel.horizontalAlignmentMode = .center
        titleLabel.verticalAlignmentMode = .center
        titleLabel.zPosition = ZPosition.titleScreenElement
        addChild(titleLabel)
        
        startCreateButton.text = "Create"
        startCreateButton.color = Color.buttonGreen
        startCreateButton.zPosition = ZPosition.titleScreenElement
        addChild(startCreateButton)
        
        startDemoButton.text = "Demo"
        startDemoButton.color = Color.buttonBlue
        startDemoButton.zPosition = ZPosition.titleScreenElement
        addChild(startDemoButton)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Tile\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        background.size = Size.sceneSize
        
        titleLabel.fontSize = Size.titleFontSize
        titleLabel.position.y = 0.25 * Size.sceneSize.height
        
        startCreateButton.updateSize()
        startCreateButton.position.x = -0.75 * Size.textButton.width
        startCreateButton.position.y = -0.25 * Size.sceneSize.height
        
        startDemoButton.updateSize()
        startDemoButton.position.x = 0.75 * Size.textButton.width
        startDemoButton.position.y = -0.25 * Size.sceneSize.height
    }
    
    public func update(_ delta: CGFloat) {
    }
    
}
