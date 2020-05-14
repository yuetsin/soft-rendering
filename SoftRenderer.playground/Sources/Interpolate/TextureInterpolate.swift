import Cocoa

public func TextureInterpolate(
  texture: inout NSBitmapImageRep,
  size: NSSize,
  coordsA: TextureCoords2D,
  coordsB: TextureCoords2D,
  coordsC: TextureCoords2D,
  interp: FragmentInterpolate<Double>
) -> CIColor {

  let u: Double = interp.u
  let v: Double = interp.v
  let w: Double = interp.w

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

public func TextureInterpolateWithCorrection(
  texture: inout NSBitmapImageRep,
  size: NSSize,
  rawCoordsA: TextureCoords2D,
  rawCoordsB: TextureCoords2D,
  rawCoordsC: TextureCoords2D,
  interp: FragmentInterpolate<Double>,
  zA: Double,
  zB: Double,
  zC: Double,
  z: Double
) -> CIColor {

  if zA == 0 || zB == 0 || zC == 0 || z == 0 {
    // give up perspective correction, fallback to normal one
    return TextureInterpolate(
      texture: &texture, size: size,
      coordsA: rawCoordsA, coordsB: rawCoordsB, coordsC: rawCoordsC,
      interp: interp)
  }

  let u: Double = interp.u
  let v: Double = interp.v
  let w: Double = interp.w

  let coordsA = rawCoordsA / zA
  let coordsB = rawCoordsB / zB
  let coordsC = rawCoordsC / zC

  var texU = coordsA.u * u
  texU += coordsB.u * v
  texU += coordsC.u * w

  var texV = coordsA.v * u
  texV += coordsB.v * v
  texV += coordsC.v * w

  let bitmapX = Int(texU * Double(size.width) * z)
  let bitmapY = Int(texV * Double(size.height) * z)

  return CIColor(color: texture.colorAt(x: bitmapX, y: bitmapY) ?? .clear) ?? .clear
}
