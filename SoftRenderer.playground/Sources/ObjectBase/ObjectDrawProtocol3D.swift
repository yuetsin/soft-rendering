import Foundation

public protocol ObjectDrawProtocol3D {
  func drawOn(
    target: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double], lights: inout [Light],
    camera: Camera<Double>)
}
