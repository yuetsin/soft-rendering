import Cocoa

// 2D Screen Point Coordinates
public class Vector2D<F: FloatingPoint>: ScreenPoint<F>, Equatable {

    public func toNSPoint() -> NSPoint {
        return NSMakePoint(x as! CGFloat, y as! CGFloat)
    }
}

public class Vector2i: Equatable {
    public var x: Int
    public var y: Int
    
    public init(_ X: Int, _ Y: Int) {
        x = X
        y = Y
    }
    
    public static func ==(left: Vector2i, right: Vector2i) -> Bool {
        return left.x == right.x && left.y == right.y
    }
}

// overload operations

public func ==<F>(left: Vector2D<F>, right: Vector2D<F>) -> Bool {
    return left.x == right.x && left.y == right.y
}

public func +<F>(left: Vector2D<F>, right: Vector2D<F>) -> Vector2D<F> {
    return Vector2D<F>(left.x + right.x, left.y + right.y)
}

public func -<F>(left: Vector2D<F>, right: Vector2D<F>) -> Vector2D<F> {
    return Vector2D<F>(left.x - right.x, left.y - right.y)
}

public func *<F>(left: Vector2D<F>, right: F) -> Vector2D<F> {
    return Vector2D<F>(left.x * right, left.y * right)
}

public func *<F>(left: Vector2D<F>, right: Vector2D<F>) -> F {
    return left.x * right.x + left.y + right.y
}

public func /<F>(left: Vector2D<F>, right: F) -> Vector2D<F> {
    return Vector2D<F>(left.x / right, left.y / right)
}
