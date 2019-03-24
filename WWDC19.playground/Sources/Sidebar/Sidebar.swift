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
        get { return buttonsSection.buttonDelegate }
        set { buttonsSection.buttonDelegate = newValue }
    }
    
    var editingBoard: Bool {
        didSet {
            updatePositioning()
            carSection.editingBoard = editingBoard
            buttonsSection.editingBoard = editingBoard
        }
    }
    
    private let background: SKSpriteNode
    private let tileSelector: TileSelector
    
    private var carSection: CarSidebarSection
    private var buttonsSection: ButtonsSidebarSection
    
    public override init() {
        background = SKSpriteNode()
        tileSelector = TileSelector()
        carSection = CarSidebarSection()
        buttonsSection = ButtonsSidebarSection()
        editingBoard = false
        super.init()
        
        background.color = SKColor(white: 0, alpha: 0.75)
        background.zPosition = ZPosition.overlay
        addChild(background)
        
        addChild(tileSelector)
        
        addChild(carSection)
        addChild(buttonsSection)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Sidebar\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        background.size[keyPath: Size.longScreenDimension] = Size.sidebarWidth
        background.size[keyPath: Size.shortScreenDimension] = Size.sceneSize[keyPath: Size.shortScreenDimension]
        
        tileSelector.updateSize()
        
        carSection.updateSize()
        buttonsSection.updateSize()
        
        updatePositioning()
    }
    
    public func update(_ currentTime: TimeInterval) {
        
    }
    
    private func updatePositioning(animate: Bool = false) {
        let offset: CGFloat = (editingBoard ? -0.5 : 0) * background.size[keyPath: Size.longScreenDimension]
        
        var backgroundTargetPosition: CGPoint = .zero
        backgroundTargetPosition[keyPath: Size.longScreenAxis] = 0.5 * Size.sceneSize[keyPath: Size.longScreenDimension] + offset
        backgroundTargetPosition[keyPath: Size.shortScreenAxis] = 0
        background.run(.move(to: backgroundTargetPosition, duration: Duration.magnetSnapAnimation),
                       timingMode: .easeInEaseOut)
        
        var tileSelectorTargetPosition: CGPoint = .zero
        tileSelectorTargetPosition[keyPath: Size.longScreenAxis] = (editingBoard ? 0 : 0.5) * Size.sidebarWidth
        tileSelectorTargetPosition[keyPath: Size.shortScreenAxis] = 0
        tileSelector.run(.group([
            .move(to: tileSelectorTargetPosition, duration: Duration.magnetSnapAnimation),
            .fadeAlpha(to: editingBoard ? 1 : 0, duration: Duration.magnetSnapAnimation)
        ]), timingMode: .easeInEaseOut)
        
        carSection.position[keyPath: Size.longScreenAxis] = 0.5 * Size.sceneSize[keyPath: Size.longScreenDimension] - 0.25 * Size.sidebarWidth
        carSection.position[keyPath: Size.shortScreenAxis] = 0
        
        var buttonSectionPosition: CGPoint = .zero
        buttonSectionPosition[keyPath: Size.longScreenAxis] = 0.5 * Size.sceneSize[keyPath: Size.longScreenDimension] - (editingBoard ? 0.5 : 0.25) * Size.sidebarWidth
        buttonSectionPosition[keyPath: Size.shortScreenAxis] = (Size.longScreenAxis == \CGPoint.x ? 1 : -1) * (0.5 * Size.sceneSize[keyPath: Size.shortScreenDimension] - 0.75 * Size.boardTile.width)
        buttonsSection.run(.move(to: buttonSectionPosition,
                                 duration: Duration.magnetSnapAnimation),
                           timingMode: .easeInEaseOut)
    }
}
