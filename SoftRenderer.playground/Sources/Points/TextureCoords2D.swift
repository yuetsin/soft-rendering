import Foundation

public struct TextureCoords2D {
    public var u: Double!
    public var v: Double!
    
    public init(_ U: Double, _ V: Double) {
        u = U
        v = V
    }
    
    public static let leftTop = TextureCoords2D(0, 0)
    public static let rightTop = TextureCoords2D(1, 0)
    public static let leftBottom = TextureCoords2D(1, 0)
    public static let rightBottom = TextureCoords2D(1, 1)
}

