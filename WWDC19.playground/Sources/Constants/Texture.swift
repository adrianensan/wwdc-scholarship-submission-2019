import SpriteKit

public struct Texture {
    
    static var backgroundWoodBlock: SKTexture!
    
    static var buttonShape: SKTexture!
    static var tileOptionsPopup: SKTexture!
    static var rotateIcon: SKTexture!
    
    static var car: SKTexture!
    
    // Tiles
    static var tileShadow: SKTexture!
    static var placeholderTile: SKTexture!
    static var grassTile: SKTexture!
    static var straightRoad: SKTexture!
    static var straightWideRoad: SKTexture!
    static var narrowToWideRoad: SKTexture!
    static var curvedRoad: SKTexture!
    static var curvedWideRoad: SKTexture!
    
    static var grassAccent: SKTexture!
    
    static func regenerateTextures() {
        backgroundWoodBlock = BackgroundWoodBlockGenerator.generate()
        
        buttonShape = ButtonShapeTextureGenerator.generate()
        tileOptionsPopup = TileOptionsPopupTextureGenerator.generate()
        rotateIcon = RotateIconTextureGenerator.generate()
        
        car = CarTextureGenerator.generate()
        
        tileShadow = TileShadowTextureGenerator.generate()
        placeholderTile = TilePlaceholderTextureGenerator.generate()
        grassTile = GrassTileTextureGenerator.generate()
        straightRoad = StraightRoadTextureGenerator.generate()
        straightWideRoad = StraightWideRoadTextureGenerator.generate()
        narrowToWideRoad = NarrowToWideRoadTextureGenerator.generate()
        curvedRoad = CurvedRoadTextureGenerator.generate()
        curvedWideRoad = CurvedWideRoadTextureGenerator.generate()
        
        grassAccent = GrassAccentTextureGenerator.generate()
    }
}

