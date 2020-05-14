import Foundation

// 3D World Point Coordinates
public class Vector3D<F: FloatingPoint>: ScreenPoint<F>, Equatable {

  public var z: F

  public init(_ x: F, _ y: F, _ z: F) {
    self.z = z
    super.init(x, y)
  }

  public override init() {
    self.z = .zero
    super.init(.zero, .zero)
  }

  public func toVector3d() -> Vector3d {
    return Vector3d(x as! Double, y as! Double, z as! Double)
  }

  public func toZoo() -> Vector3D<F> {
    return Vector3D<F>(x, y, 1 / z)
  }

  @inlinable
  public func magnitude() -> F {
    return sqrt(x * x + y * y + z * z)
  }

  @inlinable
  public func normalize() -> Vector3D<F> {
    let scale = sqrt(x * x + y * y + z * z)
    return Vector3D<F>(x / scale, y / scale, z / scale)
  }

  @inlinable
  public func cross(with right: Vector3D<F>) -> Vector3D<F> {
    return Vector3D<F>(
      self.y * right.z - right.y * self.z, self.z * right.x - self.x * right.z,
      self.x * right.y - right.x * self.y)
  }

  @inlinable
  public func toString() -> String {
    return "x: \(x) y: \(y) z: \(z)"
  }
}

public prefix func - <F>(value: Vector3D<F>) -> Vector3D<F> {
  return Vector3D<F>(-value.x, -value.y, -value.z)
}

public func == <F>(left: Vector3D<F>, right: Vector3D<F>) -> Bool {
  return left.x == right.x && left.y == right.y && left.z == right.z
}

public func + <F>(left: Vector3D<F>, right: Vector3D<F>) -> Vector3D<F> {
  return Vector3D<F>(left.x + right.x, left.y + right.y, left.z + right.z)
}

public func - <F>(left: Vector3D<F>, right: Vector3D<F>) -> Vector3D<F> {
  return Vector3D<F>(left.x - right.x, left.y - right.y, left.z - right.z)
}

public func * <F>(left: Vector3D<F>, right: F) -> Vector3D<F> {
  return Vector3D<F>(left.x * right, left.y * right, left.z * right)
}

public func * <F>(left: Vector3D<F>, right: Vector3D<F>) -> F {
  return left.x * right.x + left.y * right.y + left.z * right.z
}

public func / <F>(left: Vector3D<F>, right: F) -> Vector3D<F> {
  return Vector3D<F>(left.x / right, left.y / right, left.z / right)
}
