import SpriteKit

public struct Size {

    static var sceneSize: CGSize = .zero
    static var longScreenDimension: WritableKeyPath<CGSize, CGFloat> = \CGSize.width
    static var shortScreenDimension: WritableKeyPath<CGSize, CGFloat> = \CGSize.height
    static var longScreenAxis: WritableKeyPath<CGPoint, CGFloat> = \CGPoint.x
    static var shortScreenAxis: WritableKeyPath<CGPoint, CGFloat> = \CGPoint.y
    
    static var sceneObjectRadius: CGFloat = 0
    
    static var backgroundWoodBlock: CGSize = .zero
    
    static var textButton: CGSize = .zero
    
    static var board: CGSize = .zero
    static var boardTile: CGSize = .zero
    static var roadLaneWidth: CGFloat = 0
    static var roadDividerWidth: CGFloat = 0
    static var roadOutlineWidth: CGFloat = 0
    
    static var secondaryFontSize: CGFloat = 0
    static var titleFontSize: CGFloat = 0
    static var subTitleFontSize: CGFloat = 0
    
    static var sidebarWidth: CGFloat = 0
    static var carWidth: CGFloat = 0
    static var carHeight: CGFloat = 0
    
    static func updateSizing(sceneSize: CGSize) {
        let unit: CGFloat = 0.01 * min(sceneSize.width, sceneSize.height)
        
        Size.sceneSize = sceneSize
        longScreenDimension = sceneSize.width > sceneSize.height ? \CGSize.width : \CGSize.height
        shortScreenDimension = sceneSize.width > sceneSize.height ? \CGSize.height : \CGSize.width
        longScreenAxis = sceneSize.width > sceneSize.height ? \CGPoint.x : \CGPoint.y
        shortScreenAxis = sceneSize.width > sceneSize.height ? \CGPoint.y : \CGPoint.x
        
        sceneObjectRadius = 0.75 * sceneSize.diagonal
        
        backgroundWoodBlock = CGSize(width: 35 * unit, height: 5.1 * unit)
        
        textButton = CGSize(width: 15 * unit, height: 5 * unit)
        
        board = CGSize(width: 75 * unit, height: 75 * unit)
        boardTile = board / CGFloat(Board.tileCount)
        
        roadLaneWidth = 0.2 * boardTile.height
        roadDividerWidth = 0.025 * boardTile.height
        roadOutlineWidth = 0.01 * boardTile.height
        
        titleFontSize = 7 * unit
        subTitleFontSize = 4 * unit
        secondaryFontSize = 1.8 * unit
        
        sidebarWidth = 2.75 * Size.boardTile.width
        
        carWidth = 0.75 * Size.roadLaneWidth
        carHeight = 2.2 * carWidth
        
        Texture.regenerateTextures()
    }
    
}
