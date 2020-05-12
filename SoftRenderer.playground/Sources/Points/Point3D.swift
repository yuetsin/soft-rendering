import Foundation

// 3D World Point Coordinates
public struct Point3D<F: FloatingPoint> {
    var x: F
    var y: F
    var z: F
    
    public init(x: F, y: F, z: F) {
        self.x = x
        self.y = y
        self.z = z
    }
}

func +<F>(left: Point3D<F>, right: Point3D<F>) -> Point3D<F> {
    return Point3D<F>(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
}

func -<F>(left: Point3D<F>, right: Point3D<F>) -> Point3D<F> {
    return Point3D<F>(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
}
