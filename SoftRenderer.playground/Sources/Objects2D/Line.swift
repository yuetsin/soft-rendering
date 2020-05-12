import Cocoa

public class Line: Object2D, ObjectDrawProtocol {
    
    var lineBeginPos, lineEndPos: Point2d!
    var lineBeginColor, lineEndColor: NSColor!
    var lineStrokeWidth: CGFloat!
//    var singleColor: Bool!
    
    public init(objectPosition position: Point2d,
         worldSize size: CGSize,
         strokeWidth: CGFloat,
         beginPoint: Point2d,
         endPoint: Point2d,
         color: NSColor,
         endColor: NSColor?) {
        super.init(objectPosition: position, worldSize: size)
        
        objectPosition = position
        worldSize = size
        
        lineStrokeWidth = strokeWidth
        
        // should have a basePosition
        lineBeginPos = beginPoint + position
        lineEndPos = endPoint + position
        lineBeginColor = color
        
        // if no `endColor` provided, use begin color instead
        lineEndColor = endColor ?? color
    }
    
    public func drawOn(target: inout [Pixel]) {
        // Bersenham's line drawing technique
        
        
    }
}
