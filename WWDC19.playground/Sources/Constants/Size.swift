import SpriteKit

public struct Size {

    static var sceneSize: CGSize = .zero
    static var board: CGSize = .zero
    static var boardTile: CGSize = .zero
    static var roadLaneWidth: CGFloat = 0
    static var roadDividerWidth: CGFloat = 0
    
    static func updateSizing(sceneSize: CGSize) {
        let unit: CGFloat = 0.01 * min(sceneSize.width, sceneSize.height)
        
        Size.sceneSize = sceneSize
        board = CGSize(width: 75 * unit, height: 75 * unit)
        boardTile = board / CGFloat(Board.tileCount)
        
        roadLaneWidth = 0.2 * boardTile.height
        roadDividerWidth = 0.02 * boardTile.height
        
        Texture.regenerateTextures()
    }
    
}