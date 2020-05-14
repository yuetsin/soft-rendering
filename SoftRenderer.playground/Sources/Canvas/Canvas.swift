import Cocoa
import CoreGraphics

public struct SRCanvas {
    // basic
    
    public var imageSize: CGSize!
    public var canvasBgColor: CIColor!
    public var worldCamera: Camera<Double>!
    
    // canvas buffer
    public var imageBuffer: [Pixel]!
    public var zBuffer: [Double]!
    public var worldLights: [Light]!

    // pre-rendering object queues
    public var objects2D: [ObjectDrawProtocol2D] = []
    public var objects3D: [ObjectDrawProtocol3D] = []
    
    public func getObject2DCount() -> Int {
        return objects2D.count
    }
    
    public func getObject3DCount() -> Int {
        return objects3D.count
    }
    
    public func getLightsCount() -> Int {
        return worldLights.count
    }

    public init(size canvasSize: CGSize = defaultSize, color bgColor: CIColor = defaultColor) {
        // use NSView as a Canvas
        imageSize = canvasSize
        canvasBgColor = bgColor
        worldLights = []
        worldCamera = defaultCamera
        refreshCanvas(size: canvasSize, color: bgColor)
    }
    
    // clear canvas, pixel buffer, and depth buffer
    mutating func refreshCanvas(size canvasSize: CGSize, color fillColor: CIColor) {
        let bgPixel = color2Pixel(color: fillColor)
        let pixelCount = Int(canvasSize.width * canvasSize.height)
        imageBuffer = [Pixel](repeating: bgPixel, count: pixelCount)
        zBuffer = [Double](repeating: Double.infinity, count: pixelCount)
    }
    
    mutating public func moveCamera(offset: CGSize) {
//        NSLog("operating move \(offset)")
        let moveFactor: Double = 100
        let distance = (worldCamera.lookingAtPos - worldCamera.eyePos).magnitude()
        let watchVector = (worldCamera.lookingAtPos - worldCamera.eyePos)
        
        let moveXVector = worldCamera.up.cross(with: watchVector).normalize() * (-Double(offset.width) / moveFactor)
        let moveYVector = worldCamera.up.normalize() * (Double(offset.height) / moveFactor)
        
        let resultOffset = (worldCamera.eyePos + moveXVector + moveYVector).normalize() * distance
        
        worldCamera.eyePos = worldCamera.lookingAtPos + resultOffset
    }
    
    // add drawable objects to pre-rendering queues
    mutating public func addObject(object: ObjectDrawProtocol2D) {
        objects2D.append(object)
    }
    
    mutating public func addObject(object: ObjectDrawProtocol3D) {
        objects3D.append(object)
    }

    // directly draw objects to buffer
    mutating public func drawObject(object: ObjectDrawProtocol2D) {
        object.drawOn(target: &imageBuffer, canvasSize: imageSize)
    }
    
    mutating public func drawObject(object: ObjectDrawProtocol3D) {
        object.drawOn(target: &imageBuffer, canvasSize: imageSize, depthBuffer: &zBuffer, lights: &worldLights, camera: worldCamera)
    }
    
    mutating public func clearObject2D() {
        objects2D.removeAll()
    }
    
    mutating public func clearObject3D() {
        objects3D.removeAll()
    }
    
    // redraw any objects to the buffer, and resample it
    public mutating func render() {
        refreshCanvas(size: imageSize, color: canvasBgColor)
        
        // render 3D objects first
        for object3D in objects3D {
            drawObject(object: object3D)
        }
        
        // and 2D objects later
        for object2D in objects2D {
            drawObject(object: object2D)
        }
    }
    
    // generate image from the buffer
    public mutating func resample() -> NSImage? {
        return BitmapHelper.convertToBitmap(pixels: &imageBuffer!, size: imageSize)
    }
}
