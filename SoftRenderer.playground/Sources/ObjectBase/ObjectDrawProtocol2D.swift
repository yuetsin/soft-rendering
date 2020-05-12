import Cocoa

public protocol ObjectDrawProtocol2D {
    func drawOn(target: inout [Pixel], canvasSize: CGSize)
}
