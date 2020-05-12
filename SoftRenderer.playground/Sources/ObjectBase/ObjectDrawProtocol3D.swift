import Foundation

public protocol ObjectDrawProtocol3D {
    func drawOn(target: inout [Pixel], camera: Camera, lights: [Light])
}
