import SpriteKit

public class Sidebar: SKNode {
    
    var objectDelegate: BoardObjectDelegate? {
        get { return carSection.objectDelegate }
        set {
            carSection.objectDelegate = newValue
            
        }
    }
    
    var tileDelegate: NewTileDelegate? {
        get { return tileSelector.delegate }
        set { tileSelector.delegate = newValue }
    }
    
    var buttonDelegate: ButtonDelegate? {
        get { return editBoardButton.delegate }
        set {
            editBoardButton.delegate = newValue
            clearBoardButton.delegate = newValue
        }
    }
    
    var editingBoard: Bool {
        didSet {
            updatePositioning()
            editBoardButton.text = editingBoard ? "OK" : "Edit Board"
            
            carSection.editingBoard = editingBoard
        }
    }
    
    private let background: SKSpriteNode
    private let tileSelector: TileSelector
    
    private var carSection: CarSidebarSection
    
    private var editBoardButton: Button
    private var clearBoardButton: Button
    
    public override init() {
        background = SKSpriteNode()
        tileSelector = TileSelector()
        carSection = CarSidebarSection()
        editBoardButton = Button(id: ID.editBoardButton)
        clearBoardButton = Button(id: ID.clearBoardButton)
        editingBoard = false
        super.init()
        
        background.color = SKColor(white: 0, alpha: 0.75)
        background.zPosition = ZPosition.overlay
        addChild(background)
        
        addChild(tileSelector)
        
        addChild(carSection)
        
        editBoardButton.text = "Edit Board"
        editBoardButton.color = Color.buttonBlue
        editBoardButton.zPosition = ZPosition.overlayTile
        addChild(editBoardButton)
        
        clearBoardButton.text = "Clear Board"
        clearBoardButton.color = Color.buttonRed
        clearBoardButton.zPosition = ZPosition.overlayTile
        addChild(clearBoardButton)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Sidebar\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        let longSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.height : \CGSize.width
        let shortSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.width : \CGSize.height
        
        background.size[keyPath: shortSide] = 2.75 * Size.boardTile[keyPath: shortSide]
        background.size[keyPath: longSide] = Size.sceneSize[keyPath: longSide]
        
        tileSelector.updateSize()
        
        carSection.updateSize()
        
        editBoardButton.updateSize()
        clearBoardButton.updateSize()
        updatePositioning()
    }
    
    public func update(_ currentTime: TimeInterval) {
        
    }
    
    private func updatePositioning(animate: Bool = false) {
        let longSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.height : \CGSize.width
        let shortSide = Size.sceneSize.width > Size.sceneSize.height ? \CGSize.width : \CGSize.height
        let point1 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.x : \CGPoint.y
        let point2 = Size.sceneSize.width > Size.sceneSize.height ? \CGPoint.y : \CGPoint.x
        
        let offset: CGFloat = (editingBoard ? -0.5 : 0) * background.size[keyPath: shortSide]
        
        var backgroundTargetPosition: CGPoint = .zero
        backgroundTargetPosition[keyPath: point1] = 0.5 * Size.sceneSize[keyPath: shortSide] + offset
        backgroundTargetPosition[keyPath: point2] = 0
        background.run(.move(to: backgroundTargetPosition, duration: Duration.magnetSnapAnimation),
                       timingMode: .easeInEaseOut)
        
        var tileSelectorTargetPosition: CGPoint = .zero
        tileSelectorTargetPosition[keyPath: point1] = (editingBoard ? 0 : 0.5) * background.size[keyPath: shortSide]
        tileSelectorTargetPosition[keyPath: point2] = 0
        tileSelector.run(.group([
            .move(to: tileSelectorTargetPosition, duration: Duration.magnetSnapAnimation),
            .fadeAlpha(to: editingBoard ? 1 : 0, duration: Duration.magnetSnapAnimation)
        ]), timingMode: .easeInEaseOut)
        
        carSection.position[keyPath: point1] = 0.5 * Size.sceneSize[keyPath: shortSide] - 0.25 * background.size[keyPath: shortSide]
        carSection.position[keyPath: point2] = 0
        
        var editBoardButtonTargetPosition: CGPoint = .zero
        editBoardButtonTargetPosition[keyPath: point1] = 0.5 * Size.sceneSize[keyPath: shortSide] - (editingBoard ? 0.725 : 0.25) * background.size[keyPath: shortSide]
        editBoardButtonTargetPosition[keyPath: point2] = (Size.sceneSize.width > Size.sceneSize.height ? 2.5 : -2.5) * Size.boardTile.height
        editBoardButton.run(.move(to: editBoardButtonTargetPosition, duration: Duration.magnetSnapAnimation),
                            timingMode: .easeInEaseOut)
        
        var clearBoardButtonTargetPosition: CGPoint = .zero
        clearBoardButtonTargetPosition[keyPath: point1] = 0.5 * Size.sceneSize[keyPath: shortSide] - (editingBoard ? 0.275 : -0.25) * background.size[keyPath: shortSide]
        clearBoardButtonTargetPosition[keyPath: point2] = (Size.sceneSize.width > Size.sceneSize.height ? 2.5 : -2.5) * Size.boardTile.height
        clearBoardButton.run(.group([
            .move(to: clearBoardButtonTargetPosition, duration: Duration.magnetSnapAnimation),
            .fadeAlpha(to: editingBoard ? 1 : 0, duration: Duration.magnetSnapAnimation)
        ]), timingMode: .easeInEaseOut)
    }
}
