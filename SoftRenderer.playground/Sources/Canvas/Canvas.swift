import Cocoa
import CoreGraphics

public class SRCanvas: NSImageView {
    public var imageSize: CGSize!
    private var imageBuffer: [Pixel]!

    private var objects2D: [Object2D] = []
    private var objects3D: [Object3D] = []

    public init(size canvasSize: CGSize = defaultSize, color rawBgColor: NSColor = defaultColor) {
        // use NSView as a Canvas
        super.init(frame: NSRect(origin: .zero, size: canvasSize))

        imageSize = canvasSize

        let ciColor = CIColor(color: rawBgColor)!

        let bgPixel = Pixel(a: UInt8(ciColor.alpha * 255),
                            r: UInt8(ciColor.red * 255),
                            g: UInt8(ciColor.green * 255),
                            b: UInt8(ciColor.blue * 255))

        imageBuffer = [Pixel](repeating: bgPixel, count: Int(canvasSize.width * canvasSize.height))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func drawObject<F: ObjectDrawProtocol>(object: F) {
        object.drawOn(target: &imageBuffer)
    }

    public func render() {
        image = BitmapHelper.convertToBitmap(pixels: &imageBuffer!, size: imageSize)
    }
}
