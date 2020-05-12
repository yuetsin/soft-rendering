import Cocoa
import CoreGraphics

public class SRCanvas: NSImageView {
    public var imageSize: CGSize!
    private var imageBuffer: [Pixel]!
    private var worldCamera: Camera!
    private var zBuffer: [Double]!
    private var worldLights: [Light]!

    private var objects2D: [ObjectDrawProtocol2D] = []
    private var objects3D: [ObjectDrawProtocol3D] = []

    public init(size canvasSize: CGSize = defaultSize, color bgColor: CIColor = defaultColor) {
        // use NSView as a Canvas
        super.init(frame: NSRect(origin: .zero, size: canvasSize))

        imageSize = canvasSize


        let bgPixel = Pixel(a: UInt8(bgColor.alpha * 255),
                            r: UInt8(bgColor.red * 255),
                            g: UInt8(bgColor.green * 255),
                            b: UInt8(bgColor.blue * 255))

        let pixelCount = Int(canvasSize.width * canvasSize.height)
        imageBuffer = [Pixel](repeating: bgPixel, count: pixelCount)
        zBuffer = [Double](repeating: -Double.infinity, count: pixelCount)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func drawObject<F: ObjectDrawProtocol2D>(object: F) {
        object.drawOn(target: &imageBuffer, canvasSize: imageSize)
    }
    
    public func drawObject<F: ObjectDrawProtocol3D>(object: F) {
        object.drawOn(target: &imageBuffer, camera: worldCamera, lights: worldLights)
    }

    public func render() {
        image = BitmapHelper.convertToBitmap(pixels: &imageBuffer!, size: imageSize)
    }
}
