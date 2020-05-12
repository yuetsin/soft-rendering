import Foundation

// 3D World Point Coordinates
public class Point3D<F: FloatingPoint>: ScreenPoint<F> {

    public var z: F
    
    public init(x: F, y: F, z: F) {
        self.z = z
        super.init(x: x, y: y)
    }
}

func +<F>(left: Point3D<F>, right: Point3D<F>) -> Point3D<F> {
    return Point3D<F>(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
}

func -<F>(left: Point3D<F>, right: Point3D<F>) -> Point3D<F> {
    return Point3D<F>(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
}

func *<F>(left: Point3D<F>, right: F) -> Point3D<F> {
    return Point3D<F>(x: left.x * right, y: left.y * right, z: left.z * right)
}

func *<F>(left: Point3D<F>, right: Point3D<F>) -> F {
    return left.x * right.x + left.y + right.y + left.z + right.z
}

func /<F>(left: Point3D<F>, right: F) -> Point3D<F> {
    return Point3D<F>(x: left.x / right, y: left.y / right, z: left.z / right)
}
