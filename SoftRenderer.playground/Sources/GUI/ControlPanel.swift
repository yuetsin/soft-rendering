import SwiftUI


public struct ControlPanelView: View {

    @State var image: NSImage?
    @State var canvasDebugInfo: String = ""
    @State var objectDebugInfo: String = "canvas not initialized"
    @State var lightDebugInfo: String = ""
    
    @State var lastMove: CGSize = .zero
    
    public init(size: CGSize, color: CIColor = .clear) {
        CanvasManager.canvas = SRCanvas(size: size, color: color)
        drawReferences()
    }
    
    public func drawReferences() {
        for line in generateRefrenceLines(distance: 0.5, count: 4) {
            CanvasManager.canvas?.addObject(object: line)
        }
        
        for line in generateAxis(length: 4) {
            CanvasManager.canvas?.addObject(object: line)
        }
    }
    
    public func redrawCanvas() {
        CanvasManager.canvas?.render()
        (canvasDebugInfo, objectDebugInfo, lightDebugInfo) = CanvasManager.generateDebugInfo()
        image = CanvasManager.canvas?.resample()
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
                    Text("Render")
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
                        Image(nsImage: self.image!).resizable().scaledToFit().gesture(DragGesture()
                            .onChanged { value in
                                CanvasManager.canvas?.moveCamera(offset: value.translation - self.lastMove)
                                self.lastMove = value.translation
                                self.redrawCanvas()
                        }.onEnded { _ in
                            self.lastMove = .zero
                        })
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
