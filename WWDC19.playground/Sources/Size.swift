import SpriteKit

public struct Size {

    static var board: CGSize = .zero
    static var boardTile: CGSize = .zero
    
    static func updateSizing(sceneSize: CGSize) {
        let unit: CGFloat = 0.01 * min(sceneSize.width, sceneSize.height)
        
        board = CGSize(width: 75 * unit, height: 75 * unit)
        boardTile = board / CGFloat(Board.tileCount)
        
        Texture.regenerateTextures()
    }
    
}
