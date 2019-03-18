import SpriteKit

public class Scene: SKScene {
    
    private let background: Background
    private let board: Board
    private let tileSelector: TileSelector
    private let car: Car
    
    private var editingBoard: Bool {
        didSet {
            board.showPlaceholders = editingBoard
            tileSelector.showing = editingBoard
        }
    }
    private var lastUpdateTime: TimeInterval
    
    override public init() {
        background = Background()
        board = Board()
        tileSelector = TileSelector()
        car = Car()
        editingBoard = false
        lastUpdateTime = Date().timeIntervalSince1970
        super.init(size: .zero)
        
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .black
        setScale(0.5)
        
        background.zPosition = ZPosition.background
        addChild(background)
        
        addChild(board)
        
        tileSelector.delegate = board
        addChild(tileSelector)
        
        car.updateSize()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Class \"Scene\" is only intended to be instantiated through code")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
        editingBoard = !editingBoard
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        guard size != .zero && size != oldSize else { return }
        
        Size.updateSizing(sceneSize: size)
        
        background.updateSize()
        board.updateSize()
        tileSelector.updateSize()
        car.updateSize()
    }
    
    override public func update(_ currentTime: TimeInterval) {
        let delta: CGFloat = CGFloat(currentTime - lastUpdateTime)
        lastUpdateTime = currentTime
        guard abs(delta) < 1 else { return }
        board.update(delta)
    }
    
    func touchDown(atPoint pos: CGPoint) {
        
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        
    }
    
    func touchUp(atPoint pos: CGPoint) {
        
    }
}

