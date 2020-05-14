import Cocoa
import CoreGraphics

public class SRCanvas: NSImageView {
    
    // basic
    public var imageSize: CGSize!
    public var canvasBgColor: CIColor!
    public var worldCamera: Camera<Double>!
    
    // canvas buffer
    private var imageBuffer: [Pixel]!
    private var zBuffer: [Double]!
    private var worldLights: [Light]!

    // pre-rendering object queues
    private var objects2D: [ObjectDrawProtocol2D] = []
    private var objects3D: [ObjectDrawProtocol3D] = []

    public init(size canvasSize: CGSize = defaultSize, color bgColor: CIColor = defaultColor) {
        // use NSView as a Canvas
        super.init(frame: NSRect(origin: .zero, size: canvasSize))
        imageSize = canvasSize
        canvasBgColor = bgColor
        worldLights = defaultLights
        worldCamera = defaultCamera
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
        zBuffer = [Double](repeating: Double.infinity, count: pixelCount)
    }
    
    // add drawable objects to pre-rendering queues
    public func addObject(object: ObjectDrawProtocol2D) {
        objects2D.append(object)
    }
    
    public func addObject(object: ObjectDrawProtocol3D) {
        objects3D.append(object)
    }

    // directly draw objects to buffer
    public func drawObject(object: ObjectDrawProtocol2D) {
        object.drawOn(target: &imageBuffer, canvasSize: imageSize)
    }
    
    public func drawObject(object: ObjectDrawProtocol3D) {
        object.drawOn(target: &imageBuffer, canvasSize: imageSize, depthBuffer: &zBuffer, lights: &worldLights, camera: worldCamera)
    }
    
    // redraw any objects to the buffer, and resample it
    public func render() {
        refreshCanvas(size: imageSize, color: canvasBgColor)
        
        // render 3D objects first
        for object3D in objects3D {
            drawObject(object: object3D)
        }
        
        // and 2D objects later
        for object2D in objects2D {
            drawObject(object: object2D)
        }
        resample()
    }
    
    // generate image from the buffer
    public func resample() {
        image = BitmapHelper.convertToBitmap(pixels: &imageBuffer!, size: imageSize)
    }
}
