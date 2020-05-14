import Cocoa

public class TextureFragment3D: ObjectDrawProtocol3D {
  var tPointA, tPointB, tPointC: Vector3d!
  var texture: NSBitmapImageRep!
  var textureSize: NSSize!
  var texCoordsA, texCoordsB, texCoordsC: TextureCoords2D!
  var perspectiveCorrection: Bool!

  public init(
    pointA: Vector3d,
    pointB: Vector3d,
    pointC: Vector3d,
    texImage: NSImage,
    coordsA: TextureCoords2D,
    coordsB: TextureCoords2D,
    coordsC: TextureCoords2D,
    perspCorrect: Bool = true
  ) {
    tPointA = pointA
    tPointB = pointB
    tPointC = pointC
    texture = NSBitmapImageRep(data: texImage.tiffRepresentation!)
    textureSize = texImage.size
    texCoordsA = coordsA
    texCoordsB = coordsB
    texCoordsC = coordsC
    perspectiveCorrection = perspCorrect
  }

  public func drawOn(
    target pixels: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double],
    lights: inout [Light], camera: Camera<Double>
  ) {

    let pA = transformPoint(
      point: tPointA, camera: camera, width: Double(canvasSize.width),
      height: Double(canvasSize.height))
    let pB = transformPoint(
      point: tPointB, camera: camera, width: Double(canvasSize.width),
      height: Double(canvasSize.height))
    let pC = transformPoint(
      point: tPointC, camera: camera, width: Double(canvasSize.width),
      height: Double(canvasSize.height))

    rasterize(
      canvasWidth: Double(canvasSize.width), canvasHeight: Double(canvasSize.height),
      pA: pA, pB: pB, pC: pC,
      handler: { point, interp in
        var pixel: Pixel!

        if getZBuffer(zBuffer: &depthBuffer, x: point.x, y: point.y, size: canvasSize)
          ?? Double.infinity >= point.z
        {
          var color: CIColor!
          if perspectiveCorrection {
            color = TextureInterpolateWithCorrection(
              texture: &texture, size: textureSize,
              rawCoordsA: texCoordsA, rawCoordsB: texCoordsB, rawCoordsC: texCoordsC,
              interp: interp, zA: pA.z, zB: pB.z, zC: pC.z, z: point.z)
          } else {
            color = TextureInterpolate(
              texture: &texture, size: textureSize,
              coordsA: texCoordsA, coordsB: texCoordsB,
              coordsC: texCoordsC, interp: interp)
          }
          pixel = color2Pixel(color: color)

          putPixel(pixels: &pixels, x: point.x, y: point.y, size: canvasSize, target: pixel)
          putZBuffer(
            zBuffer: &depthBuffer, x: point.x, y: point.y, size: canvasSize, target: point.z)
        }
      })
  }
}
