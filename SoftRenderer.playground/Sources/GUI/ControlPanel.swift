import SwiftUI

public struct ControlPanelView: View {

    @State var image: NSImage?
    
    @State var canvasDebugInfo: String = ""
    @State var objectDebugInfo: String = "canvas not initialized"
    @State var lightDebugInfo: String = ""
    
    public init(size: CGSize, color: CIColor = .clear) {
        CanvasManager.canvas = SRCanvas(size: size, color: color)
    }
    
    public func drawReferences() {
        for line in generateRefrenceLines(distance: 0.5, count: 5) {
            CanvasManager.canvas?.addObject(object: line)
        }
        
        for line in generateAxis(length: 5) {
            CanvasManager.canvas?.addObject(object: line)
        }
    }
    
    public func redrawCanvas() {
        CanvasManager.canvas?.render()
        image = CanvasManager.canvas?.resample()
        (canvasDebugInfo, objectDebugInfo, lightDebugInfo) = CanvasManager.generateDebugInfo()
    }
    
    public var body: some View {
        VStack {
            Text(canvasDebugInfo)
            Text(objectDebugInfo)
            Text(lightDebugInfo)
            HStack {
                Button(action: {
                    self.redrawCanvas()
                }) {
                    Text("Refresh")
                }
                Button(action: {
                    self.drawReferences()
                }) {
                    Text("Put Demo")
                }
            }
            
            VStack {
                Button(action: {
                    
                }) {
                    Text("Up")
                }
                HStack {
                    Button(action: {
                        
                    }) {
                        Text("Left")
                    }
                    if self.image != nil {
                        Image(nsImage: self.image!)
                    } else {
                        Text("[canvas not rendered]")
                    }
                    Button(action: {
                        
                    }) {
                        Text("Right")
                    }
                }
                Button(action: {
                    
                }) {
                    Text("Down")
                }
            }
        }.padding()
    }
}

struct ControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanelView(size: CGSize(width: 400, height: 300), color: .white)
    }
}
