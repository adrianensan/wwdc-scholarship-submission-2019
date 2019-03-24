import SpriteKit

public struct Color {
    
    static let backgroundWoodBlock = SKColor(red: 0.50, green: 0.24, blue: 0.08, alpha: 1)
    
    static let buttonGreen = SKColor(red: 0.20, green: 0.64, blue: 0.28, alpha: 1)
    static let buttonBlue = SKColor(red: 0.30, green: 0.34, blue: 0.68, alpha: 1)
    static let buttonRed = SKColor(red: 0.65, green: 0.24, blue: 0.28, alpha: 1)
    
    static let grass = SKColor(red: 0.22, green: 0.47, blue: 0.18, alpha: 1)
    static let grassAccent = SKColor(red: 0.2, green: 0.42, blue: 0.14, alpha: 1)
    
    static let road = SKColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1)
    static let roadDivider = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let yellowRoadDivider = SKColor(red: 0.86, green: 0.54, blue: 0.31, alpha: 1)
    
    static let carOptions: [SKColor] = [
        SKColor(red: 0.48, green: 0.26, blue: 0.24, alpha: 1),
        SKColor(red: 0.76, green: 0.33, blue: 0.24, alpha: 1),
        SKColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1),
        SKColor(red: 0.26, green: 0.27, blue: 0.35, alpha: 1),
        SKColor(red: 0.56, green: 0.68, blue: 0.75, alpha: 1),
        SKColor(red: 0.77, green: 0.75, blue: 0.58, alpha: 1),
        SKColor(red: 0.53, green: 0.61, blue: 0.61, alpha: 1),
        SKColor(red: 0.80, green: 0.44, blue: 0.20, alpha: 1),
        SKColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1),
        SKColor(red: 0.69, green: 0.73, blue: 0.67, alpha: 1)
        
    ]
    
    static var randomCar: SKColor { return carOptions.randomElement() ?? carOptions[0] }
}
