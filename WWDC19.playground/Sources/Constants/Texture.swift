import SpriteKit

public struct Texture {
    
    static var placeholderTile: SKTexture!
    static var car: SKTexture!
    
    // Tiles
    static var tileShadow: SKTexture!
    static var grassTile: SKTexture!
    static var straightRoad: SKTexture!
    static var straightWideRoad: SKTexture!
    
    static var grassAccent: SKTexture!
    
    static func regenerateTextures() {
        placeholderTile = TilePlaceholderTextureGenerator.generate()
        car = CarTextureGenerator.generate()
        
        tileShadow = TileShadowTextureGenerator.generate()
        grassTile = GrassTileTextureGenerator.generate()
        straightRoad = StraightRoadTextureGenerator.generate()
        straightWideRoad = StraightWideRoadTextureGenerator.generate()
        
        grassAccent = GrassAccentTextureGenerator.generate()
    }
}

