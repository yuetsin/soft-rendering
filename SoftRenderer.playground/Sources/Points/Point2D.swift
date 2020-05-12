import Cocoa

// 2D Screen Point Coordinates
public class Point2D<F: FloatingPoint>: ScreenPoint<F> {

    public func toNSPoint() -> NSPoint {
        return NSMakePoint(x as! CGFloat, y as! CGFloat)
    }
}

// overload operations
func +<F>(left: Point2D<F>, right: Point2D<F>) -> Point2D<F> {
    return Point2D<F>(x: left.x + right.x, y: left.y + right.y)
}

func -<F>(left: Point2D<F>, right: Point2D<F>) -> Point2D<F> {
    return Point2D<F>(x: left.x - right.x, y: left.y - right.y)
}

func *<F>(left: Point2D<F>, right: F) -> Point2D<F> {
    return Point2D<F>(x: left.x * right, y: left.y * right)
}

func *<F>(left: Point2D<F>, right: Point2D<F>) -> F {
    return left.x * right.x + left.y + right.y
}

func /<F>(left: Point2D<F>, right: F) -> Point2D<F> {
    return Point2D<F>(x: left.x / right, y: left.y / right)
}
