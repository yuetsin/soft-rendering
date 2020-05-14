
import Foundation

public class CanvasManager {
    public static var canvas: SRCanvas?
    
    public static func generateDebugInfo() -> (String, String, String) {
        if canvas == nil {
            return ("", "click [Refresh] to render image", "")
        }
        return ("canvas size: (width: \(canvas!.imageSize.width), height: \(canvas!.imageSize.height))", "camera at (\(canvas!.worldCamera.eyePos.toString())), looking at (\(canvas!.worldCamera.lookingAtPos.toString()))", "rendering \(canvas!.getObject2DCount()) 2d objects and \(canvas!.getObject3DCount()) 3d objects with \(canvas!.getLightsCount()) activate lights")
    }
}
