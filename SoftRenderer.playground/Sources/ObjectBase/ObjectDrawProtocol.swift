import Cocoa

public protocol ObjectDrawProtocol {
    func drawOn(target: inout [Pixel])
}
