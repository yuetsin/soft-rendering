import Cocoa

public struct Pixel {
    // do not mess with semi-transparent stuff
    public var a: UInt8 = 255
    public var r: UInt8
    public var g: UInt8
    public var b: UInt8

    public init(a A: UInt8, r R: UInt8, g G: UInt8, b B: UInt8) {
        a = A
        r = R
        g = G
        b = B
    }
}

@inlinable
public func color2Pixel(color: CIColor) -> Pixel {
    return Pixel(a: UInt8(color.alpha * 255),
                 r: UInt8(color.red * 255),
                 g: UInt8(color.green * 255),
                 b: UInt8(color.blue * 255))
}

@inlinable
public func pixel2Color(pixel: Pixel) -> CIColor {
    return CIColor(red: CGFloat(pixel.r) / 255.0,
            green: CGFloat(pixel.g) / 255.0,
            blue: CGFloat(pixel.b) / 255.0,
            alpha: CGFloat(pixel.a) / 255.0)
}

@inlinable
public func getPixel(pixels: inout [Pixel], x: Int, y: Int, size: CGSize) -> Pixel? {
    if x >= Int(size.width) || y >= Int(size.height) || x < 0 || y < 0 {
        return nil
    }
    return pixels[x + y * Int(size.width)]
}

@inlinable
public func putPixel(pixels: inout [Pixel], x: Int, y: Int, size: CGSize, target: Pixel) {
    if x >= Int(size.width) || y >= Int(size.height) || x < 0 || y < 0 {
        return
    }
    pixels[x + y * Int(size.width)] = target
}

@inlinable
public func putPixel(pixels: inout [Pixel], point: Vector2i, size: CGSize, target: Pixel) {
    if point.x >= Int(size.width) || point.y >= Int(size.height) || point.x < 0 || point.y < 0 {
        return
    }
    pixels[point.x + point.y * Int(size.width)] = target
}

@inlinable
public func getZBuffer(zBuffer: inout [Double], x: Int, y: Int, size: CGSize) -> Double? {
    if x >= Int(size.width) || y >= Int(size.height) || x < 0 || y < 0 {
        return nil
    }
    return zBuffer[x + y * Int(size.width)]
}

@inlinable
public func putZBuffer(zBuffer: inout [Double], x: Int, y: Int, size: CGSize, target: Double) {
    if x >= Int(size.width) || y >= Int(size.height) || x < 0 || y < 0 {
        return
    }
    zBuffer[x + y * Int(size.width)] = target
}
