import SwiftUI
import PlaygroundSupport



let canvasSize = CGSize(width: 400, height: 300)
let bgColor = CIColor.white

let view = ControlPanelView(size: canvasSize, color: .clear)

PlaygroundPage.current.setLiveView(view)
