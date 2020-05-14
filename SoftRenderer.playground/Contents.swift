import SwiftUI
import PlaygroundSupport

let canvasSize = CGSize(width: 300, height: 200)
let bgColor = CIColor.white

let view = ControlPanelView(size: canvasSize, color: .clear)

let size = CGSize(width: 800, height: 400)
let frame = CGRect(origin: .zero, size: size)
let hosting = NSHostingView(rootView: view)
hosting.frame = frame

PlaygroundPage.current.setLiveView(hosting)

