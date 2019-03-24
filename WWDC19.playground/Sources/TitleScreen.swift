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
    var howToPlayLabel: SKLabelNode
    var descriptionLabel: SKLabelNode
    var createdLabel: SKLabelNode
    
    private var startCreateButton: Button
    private var startDemoButton: Button
    
    override public init() {
        background = SKSpriteNode()
        titleLabel = SKLabelNode()
        howToPlayLabel = SKLabelNode()
        descriptionLabel = SKLabelNode()
        createdLabel = SKLabelNode()
        
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
        titleLabel.verticalAlignmentMode = .top
        titleLabel.zPosition = ZPosition.titleScreenElement
        addChild(titleLabel)
        
        howToPlayLabel.text = "How to play"
        howToPlayLabel.fontColor = .white
        howToPlayLabel.fontName = Constant.font
        howToPlayLabel.horizontalAlignmentMode = .center
        howToPlayLabel.verticalAlignmentMode = .bottom
        howToPlayLabel.zPosition = ZPosition.titleScreenElement
        addChild(howToPlayLabel)
        
        descriptionLabel.text = """
        Create a layout with the given road blocks, and place cars on the board.
        
        Cars will try to follow any nearby roads, and only deviate if there are obstructions.
        Place obstacles to see how cars react to their roads being obstructed
        
        Each car has it's own unique personality,
        which can be observed in their driving through agressiveness and patience
        """
        descriptionLabel.numberOfLines = 0
        descriptionLabel.fontColor = .white
        descriptionLabel.fontName = Constant.font
        descriptionLabel.horizontalAlignmentMode = .center
        descriptionLabel.verticalAlignmentMode = .top
        descriptionLabel.zPosition = ZPosition.titleScreenElement
        addChild(descriptionLabel)
        
        createdLabel.text = "Made with love by Adrian Ensan for WWDC19"
        createdLabel.fontColor = .white
        createdLabel.fontName = Constant.font
        createdLabel.horizontalAlignmentMode = .center
        createdLabel.verticalAlignmentMode = .center
        createdLabel.zPosition = ZPosition.titleScreenElement
        addChild(createdLabel)
        
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
        titleLabel.position.y = 0.4 * Size.sceneSize.height
        
        howToPlayLabel.fontSize = Size.subTitleFontSize
        howToPlayLabel.position.y = 0.15 * Size.sceneSize.height
        
        descriptionLabel.fontSize = Size.secondaryFontSize
        descriptionLabel.position.y = 0.12 * Size.sceneSize.height
        
        createdLabel.fontSize = Size.secondaryFontSize
        createdLabel.position.y = -0.5 * Size.sceneSize.height + 0.75 * createdLabel.calculateAccumulatedFrame().height
        
        startCreateButton.updateSize()
        startCreateButton.position.x = -0.75 * Size.textButton.width
        startCreateButton.position.y = -0.3 * Size.sceneSize.height
        
        startDemoButton.updateSize()
        startDemoButton.position.x = 0.75 * Size.textButton.width
        startDemoButton.position.y = -0.3 * Size.sceneSize.height
    }
    
    public func update(_ delta: CGFloat) {
    }
    
}
