import Foundation

// 3D World Point Coordinates
public class Vector3D<F: FloatingPoint>: ScreenPoint<F>, Equatable {

    public var z: F
    
    public init(_ x: F, _ y: F, _ z: F) {
        self.z = z
        super.init(x, y)
    }
}

public class Vector3i: Equatable {
    public var x: Int
    public var y: Int
    public var z: Double
    
    public init(_ X: Int, _ Y: Int, _ Z: Double) {
        x = X
        y = Y
        z = Z
    }
    
    public static func ==(left: Vector3i, right: Vector3i) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }
}

public func ==<F>(left: Vector3D<F>, right: Vector3D<F>) -> Bool {
    return left.x == right.x && left.y == right.y && left.z == right.z
}

public func +<F>(left: Vector3D<F>, right: Vector3D<F>) -> Vector3D<F> {
    return Vector3D<F>(left.x + right.x, left.y + right.y, left.z + right.z)
}

public func -<F>(left: Vector3D<F>, right: Vector3D<F>) -> Vector3D<F> {
    return Vector3D<F>(left.x - right.x, left.y - right.y, left.z - right.z)
}

public func *<F>(left: Vector3D<F>, right: F) -> Vector3D<F> {
    return Vector3D<F>(left.x * right, left.y * right, left.z * right)
}

public func *<F>(left: Vector3D<F>, right: Vector3D<F>) -> F {
    return left.x * right.x + left.y + right.y + left.z + right.z
}

public func /<F>(left: Vector3D<F>, right: F) -> Vector3D<F> {
    return Vector3D<F>(left.x / right, left.y / right, left.z / right)
}
