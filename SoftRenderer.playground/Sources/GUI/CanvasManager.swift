
import Foundation

class CanvasManager {
    public static var canvas: SRCanvas?
    
    public static func generateDebugInfo() -> String {
        if canvas == nil {
            return "canvas not initialized"
        }
        return "camera at (\(canvas!.worldCamera.eyePos.toString())), looking at (\(canvas!.worldCamera.lookingAtPos.toString()))"
    }
}
