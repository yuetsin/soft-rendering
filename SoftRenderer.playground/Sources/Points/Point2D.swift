import Cocoa

// 2D Screen Point Coordinates
public struct Point2D<F: FloatingPoint> {
    public var x: F
    public var y: F
    
    public init(x: F, y: F) {
        self.x = x
        self.y = y
    }

    func nsPoint() -> NSPoint {
        return NSMakePoint(x as! CGFloat, y as! CGFloat)
    }
}

func +<F>(left: Point2D<F>, right: Point2D<F>) -> Point2D<F> {
    return Point2D<F>(x: left.x + right.x, y: left.y + right.y)
}

func -<F>(left: Point2D<F>, right: Point2D<F>) -> Point2D<F> {
    return Point2D<F>(x: left.x - right.x, y: left.y - right.y)
}

func *<F>(left: Point2D<F>, right: F) -> Point2D<F> {
    return Point2D<F>(x: left.x * right, y: left.y * right)
}

func /<F>(left: Point2D<F>, right: F) -> Point2D<F> {
    return Point2D<F>(x: left.x / right, y: left.y / right)
}
