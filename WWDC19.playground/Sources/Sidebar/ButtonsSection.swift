import SpriteKit

public class ButtonsSidebarSection: SKNode {
    
    var buttonDelegate: ButtonDelegate? {
        get { return editBoardButton.delegate }
        set {
            editBoardButton.delegate = newValue
            clearBoardButton.delegate = newValue
        }
    }
    
    var editingBoard: Bool {
        didSet {
            clearBoardButton.run(.fadeAlpha(to: editingBoard ? 1 : 0, duration: Duration.magnetSnapAnimation))
            editBoardButton.text = editingBoard ? "OK" : "Edit Board"
            editBoardButton.color = editingBoard ? Color.buttonGreen : Color.buttonBlue
            updatePositioning()
        }
    }
    
    private var titleScreenButton: Button
    private var editBoardButton: Button
    private var clearBoardButton: Button
    
    override public init() {
        editingBoard = false
        titleScreenButton = Button(id: ID.titleScreenButton)
        editBoardButton = Button(id: ID.editBoardButton)
        clearBoardButton = Button(id: ID.clearBoardButton)
        super.init()
        
        titleScreenButton.text = "Title Screen"
        titleScreenButton.color = Color.buttonBlue
        titleScreenButton.zPosition = ZPosition.overlayTile
        addChild(titleScreenButton)
        
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
        fatalError("Class \"CarSidebarSection\" is only intended to be instantiated through code")
    }
    
    public func updateSize() {
        titleScreenButton.updateSize()
        editBoardButton.updateSize()
        clearBoardButton.updateSize()
        updatePositioning()
    }
    
    public func update(_ currentTime: TimeInterval) {
        
    }
    
    private func updatePositioning() {
        let titleScreenButtonsStartPostition: CGPoint
        let boardEditButtonsStartPostition: CGPoint
        if Size.longScreenAxis == \CGPoint.x {
            titleScreenButtonsStartPostition = CGPoint(x: !editingBoard ? 0 : -0.625 * Size.boardTile.width,
                                                       y: editingBoard ? 0 : 0.25 * Size.boardTile.height)
            boardEditButtonsStartPostition = CGPoint(x: !editingBoard ? 0 : 0.625 * Size.boardTile.width,
                                                     y: (editingBoard ? 0.25 : -0.25) * Size.boardTile.height)
        }
        else {
            titleScreenButtonsStartPostition = CGPoint(x: 0, y: (editingBoard ? 0.5 : 0.25) * Size.boardTile.height)
            boardEditButtonsStartPostition = CGPoint(x: 0, y: (editingBoard ? 0 : -0.25) * Size.boardTile.height)
        }
        
        titleScreenButton.run(.move(to: titleScreenButtonsStartPostition,
                                    duration: Duration.magnetSnapAnimation),
                              timingMode: .easeInEaseOut)
        editBoardButton.run(.move(to: boardEditButtonsStartPostition,
                                  duration: Duration.magnetSnapAnimation),
                            timingMode: .easeInEaseOut)
        clearBoardButton.run(.move(to: boardEditButtonsStartPostition + CGPoint(x: 0, y: -0.5 * Size.boardTile.height),
                                   duration: Duration.magnetSnapAnimation),
                             timingMode: .easeInEaseOut)
    }
}
