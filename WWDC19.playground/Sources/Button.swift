import SpriteKit

public class Button: SKNode {
    
    var delegate: ButtonDelegate?
    
    var isEnabled: Bool {
        get { return isUserInteractionEnabled }
        set { isUserInteractionEnabled = newValue }
    }
    
    var text: String? {
        get { return textNode.text }
        set { textNode.text = newValue }
    }
    
    var color: SKColor {
        get { return shapeNode.color }
        set { shapeNode.color = newValue }
    }
    
    private var isSelected: Bool {
        didSet {
    
        }
    }
    private let id: Int
    private let shapeNode: SKSpriteNode
    private let textNode: SKLabelNode
    
    public init(id: Int) {
        self.id = id
        shapeNode = SKSpriteNode()
        textNode = SKLabelNode()
        isSelected = false
        super.init()
        
        shapeNode.zPosition = ZPosition.buttonBackground
        shapeNode.colorBlendFactor = 1
        addChild(shapeNode)
        
        textNode.fontColor = .white
        textNode.fontName = Constant.font
        textNode.horizontalAlignmentMode = .center
        textNode.verticalAlignmentMode = .center
        textNode.zPosition = ZPosition.buttonText
        addChild(textNode)
        
        isEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Tile\" is only intended to be instantiated through code")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = true
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSelected { delegate?.buttonTapped(id: id) }
        isSelected = false
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = false
    }
    
    public func updateSize() {
        shapeNode.texture = Texture.buttonShape
        shapeNode.size = Texture.buttonShape.size()
        
        textNode.fontSize = Size.secondaryFontSize
    }
    
    public func update(_ delta: CGFloat) {
    }
    
}

protocol ButtonDelegate: AnyObject {
    func buttonTapped(id: Int)
}
