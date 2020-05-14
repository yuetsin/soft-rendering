import Foundation

public class RenderPoint: Equatable {
    public var x: Int
    public var y: Int
    public var z: Double
    
    public init(_ X: Int, _ Y: Int, _ Z: Double) {
        x = X
        y = Y
        z = Z
    }
    
    public static func ==(left: RenderPoint, right: RenderPoint) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }
    
    public func toVector3d() -> Vector3d{
        return Vector3d(Double(x), Double(y), z)
    }
}
