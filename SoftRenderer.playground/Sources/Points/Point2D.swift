import Cocoa

// 2D Screen Point Coordinates
public class Point2D<F: FloatingPoint>: ScreenPoint<F>, Equatable {

    public func toNSPoint() -> NSPoint {
        return NSMakePoint(x as! CGFloat, y as! CGFloat)
    }
}

public class Point2i: Equatable {
    public var x: Int
    public var y: Int
    
    public init(_ X: Int, _ Y: Int) {
        x = X
        y = Y
    }
    
    public static func ==(left: Point2i, right: Point2i) -> Bool {
        return left.x == right.x && left.y == right.y
    }
}

// overload operations

public func ==<F>(left: Point2D<F>, right: Point2D<F>) -> Bool {
    return left.x == right.x && left.y == right.y
}

public func +<F>(left: Point2D<F>, right: Point2D<F>) -> Point2D<F> {
    return Point2D<F>(left.x + right.x, left.y + right.y)
}

public func -<F>(left: Point2D<F>, right: Point2D<F>) -> Point2D<F> {
    return Point2D<F>(left.x - right.x, left.y - right.y)
}

public func *<F>(left: Point2D<F>, right: F) -> Point2D<F> {
    return Point2D<F>(left.x * right, left.y * right)
}

public func *<F>(left: Point2D<F>, right: Point2D<F>) -> F {
    return left.x * right.x + left.y + right.y
}

public func /<F>(left: Point2D<F>, right: F) -> Point2D<F> {
    return Point2D<F>(left.x / right, left.y / right)
}
