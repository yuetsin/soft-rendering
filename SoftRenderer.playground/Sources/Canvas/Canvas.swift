import Cocoa
import CoreGraphics

public class SRCanvas: NSImageView {
    
    // basic
    public var imageSize: CGSize!

    private var worldCamera: Camera! = defaultCamera
    
    // canvas buffer
    private var imageBuffer: [Pixel]!
    private var zBuffer: [Double]!
    private var worldLights: [Light]! = []

    // pre-rendering object queues
    private var objects2D: [ObjectDrawProtocol2D] = []
    private var objects3D: [ObjectDrawProtocol3D] = []

    public init(size canvasSize: CGSize = defaultSize, color bgColor: CIColor = defaultColor) {
        // use NSView as a Canvas
        super.init(frame: NSRect(origin: .zero, size: canvasSize))
        imageSize = canvasSize
        
        refreshCanvas(size: canvasSize, color: bgColor)
    }
    
    // Storyboard initialize not allowed
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // clear canvas, pixel buffer, and depth buffer
    func refreshCanvas(size canvasSize: CGSize, color fillColor: CIColor) {
        let bgPixel = color2Pixel(color: fillColor)
        let pixelCount = Int(canvasSize.width * canvasSize.height)
        imageBuffer = [Pixel](repeating: bgPixel, count: pixelCount)
        zBuffer = [Double](repeating: -Double.infinity, count: pixelCount)
    }
    
    // add drawable objects to pre-rendering queues
    public func addObject(object: ObjectDrawProtocol2D) {
        objects2D.append(object)
    }
    
    public func addObject(object: ObjectDrawProtocol3D) {
        objects3D.append(object)
    }

    // directly draw objects to buffer
    private func drawObject(object: ObjectDrawProtocol2D) {
        object.drawOn(target: &imageBuffer, canvasSize: imageSize)
    }
    
    private func drawObject(object: ObjectDrawProtocol3D) {
        object.drawOn(target: &imageBuffer, canvasSize: imageSize, depthBuffer: &zBuffer, lights: &worldLights, camera: worldCamera)
    }
    
    // render the buffer to NSImage object
    public func render() {
        // render 3D objects first
        for object3D in objects3D {
            drawObject(object: object3D)
        }
        
        // and 2D objects later
        for object2D in objects2D {
            drawObject(object: object2D)
        }
        image = BitmapHelper.convertToBitmap(pixels: &imageBuffer!, size: imageSize)
    }
}
