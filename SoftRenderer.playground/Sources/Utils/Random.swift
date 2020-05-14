import Cocoa


public extension Double {
    static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Float {
    static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 4294967296) * (upper - lower) + lower
    }
}

public extension CGFloat {
    static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

public func randomPoint2d(size: CGSize) -> Vector2d {
    return Vector2d(Double.random(0, Double(size.width)), Double.random(0, Double(size.height)))
}

public func randomPoint3d(size: CGSize) -> Vector3d {
    return Vector3d(Double.random(0, Double(size.width)), Double.random(0, Double(size.height)), Double.random(-2, 2))
}

public func randomCIColor() -> CIColor {
    return CIColor(red: CGFloat.random(), green: CGFloat.random(), blue: CGFloat.random(), alpha: CGFloat.random())
}


