import Cocoa


public func TextureInterpolate(texture: inout NSBitmapImageRep,
                               size: NSSize,
                               coordsA: TextureCoords2D,
                               coordsB: TextureCoords2D,
                               coordsC: TextureCoords2D,
                               interp: FragmentInterpolate<Double>) -> CIColor {
    
    let u: Double = interp.u, v: Double = interp.v, w: Double = interp.w
    
    var texU = coordsA.u * u
    texU += coordsB.u * v
    texU += coordsC.u * w
    
    var texV = coordsA.v * u
    texV += coordsB.v * v
    texV += coordsC.v * w
    
    let bitmapX = Int(texU * Double(size.width))
    let bitmapY = Int(texV * Double(size.height))

    return CIColor(color: texture.colorAt(x: bitmapX, y: bitmapY) ?? .clear) ?? .clear
}
