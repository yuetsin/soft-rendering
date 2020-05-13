import Foundation

// 3D World Point Coordinates
public class Point3D<F: FloatingPoint>: ScreenPoint<F>, Equatable {

    public var z: F
    
    public init(_ x: F, _ y: F, _ z: F) {
        self.z = z
        super.init(x, y)
    }
}

public class Point3i: Equatable {
    public var x: Int
    public var y: Int
    public var z: Double
    
    public init(_ X: Int, _ Y: Int, _ Z: Double) {
        x = X
        y = Y
        z = Z
    }
    
    public static func ==(left: Point3i, right: Point3i) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }
}

public func ==<F>(left: Point3D<F>, right: Point3D<F>) -> Bool {
    return left.x == right.x && left.y == right.y && left.z == right.z
}

public func +<F>(left: Point3D<F>, right: Point3D<F>) -> Point3D<F> {
    return Point3D<F>(left.x + right.x, left.y + right.y, left.z + right.z)
}

public func -<F>(left: Point3D<F>, right: Point3D<F>) -> Point3D<F> {
    return Point3D<F>(left.x - right.x, left.y - right.y, left.z - right.z)
}

public func *<F>(left: Point3D<F>, right: F) -> Point3D<F> {
    return Point3D<F>(left.x * right, left.y * right, left.z * right)
}

public func *<F>(left: Point3D<F>, right: Point3D<F>) -> F {
    return left.x * right.x + left.y + right.y + left.z + right.z
}

public func /<F>(left: Point3D<F>, right: F) -> Point3D<F> {
    return Point3D<F>(left.x / right, left.y / right, left.z / right)
}
