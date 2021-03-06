import SpriteKit

public class Scene: SKScene {
    
    private let titleScreen: TitleScreen
    private let background: Background
    private let board: Board
    private let sidebar: Sidebar
    
    private var editingBoard: Bool {
        didSet {
            board.editable = editingBoard
            sidebar.editingBoard = editingBoard
        }
    }
    private var lastUpdateTime: TimeInterval
    
    override public init() {
        titleScreen = TitleScreen()
        background = Background()
        board = Board()
        sidebar = Sidebar()
        editingBoard = false
        lastUpdateTime = Date().timeIntervalSince1970
        super.init(size: .zero)
        
        if let fontURL = Bundle.main.url(forResource: Constant.font, withExtension: "otf") {
            CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
        }
        
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .black
        
        titleScreen.delegate = self
        addChild(titleScreen)
        
        background.zPosition = ZPosition.background
        addChild(background)
        
        addChild(board)
        
        sidebar.objectDelegate = board
        sidebar.tileDelegate = board
        sidebar.buttonDelegate = self
        addChild(sidebar)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Scene\" is only intended to be instantiated through code")
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        guard size != .zero && size != oldSize else { return }
        
        Size.updateSizing(sceneSize: size)
        
        titleScreen.updateSize()
        background.updateSize()
        board.updateSize()
        sidebar.updateSize()
    }
    
    override public func update(_ currentTime: TimeInterval) {
        let delta: CGFloat = CGFloat(currentTime - lastUpdateTime)
        lastUpdateTime = currentTime
        guard abs(delta) < 1 else { return }
        board.update(delta)
    }
}

extension Scene: ButtonDelegate {
    func buttonTapped(id: Int) {
        switch id {
        case ID.editBoardButton: editingBoard = !editingBoard
        case ID.clearBoardButton: board.clear()
        case ID.startCreateButton:
            titleScreen.run(.fadeOut(withDuration: Duration.magnetSnapAnimation))
            editingBoard = true
        case ID.startDemoButton:
            titleScreen.run(.fadeOut(withDuration: Duration.magnetSnapAnimation))
            board.setupDemo()
        default: return
        }
    }
}
