import SwiftUI

public struct ControlPanelView: View {

    @State var image: NSImage?
    
    @State var debugText: String = "hello, there"
    
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
        debugText = CanvasManager.generateDebugInfo()
    }
    
    public var body: some View {
        VStack {
            Text(debugText)
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
                    Image(nsImage: self.image ?? NSImage())
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
