import Foundation

public struct TextureCoords2D {
    public var u: Double!
    public var v: Double!
    
    public init(_ U: Double, _ V: Double) {
        u = U
        v = V
    }
    
    public static let leftTop = TextureCoords2D(0, 1)
    public static let rightTop = TextureCoords2D(1, 1)
    public static let leftBottom = TextureCoords2D(0, 0)
    public static let rightBottom = TextureCoords2D(1, 0)
}

// overload operations
public func *(left: TextureCoords2D, right: Double) -> TextureCoords2D {
    return TextureCoords2D(left.u * right, left.v * right)
}


public func /(left: TextureCoords2D, right: Double) -> TextureCoords2D {
    return TextureCoords2D(left.u / right, left.v / right)
}
