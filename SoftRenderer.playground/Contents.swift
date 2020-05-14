import SwiftUI
import PlaygroundSupport
/*:
 # Software Renderer
 
 ## Intro
  This is a toy software renderer, written in pure Swift, featured with Gouraud coloring, Z buffering, projection transforming, texture mapping, perspective correction, and Blinn-Phong lighting.

 ## Demo
 
 ### Initialization
 
 First, indicate the rendering size and background color:
 */
let canvasSize = CGSize(width: 300, height: 200)
let bgColor = CIColor.clear

let view = ControlPanelView(size: canvasSize, color: bgColor)

/*:
 `drawReferences()` will create several referencing 3D lines in rendering space.
 */
view.drawReferences()

let size = CGSize(width: 800, height: 400)
let frame = CGRect(origin: .zero, size: size)
let hosting = NSHostingView(rootView: view)

hosting.frame = frame
PlaygroundPage.current.setLiveView(hosting)

/*:
 > Run all codes above, and we've got a `ControlPanelView` in our live view field.

 After clicking `initialize` Button, the renderer will display a default space with three orthogonal directional lines, and a black-white translucent on $xOy$ plane.
 
 Camera position can be moved by dragging the rendering screen.
 */

/*:
 ### 2D Fragments
 
 Create a `Fragment2D` object, and add it into
 */

/*:
 ### 3D Fragment
 
 Creating a 3D fragment is easy: we can create a `Fragment3D` with Gouraud coloring in this way:
 */

let gouraudFragment3D = GouraudFragment3D(pointA: Vector3d(2, -1, 0),
                                          pointB: Vector3d(0, 0, 0),
                                          pointC: Vector3d(1, 0, 2),
                                          colorA: .cyan,
                                          colorB: .magenta,
                                          colorC: .yellow)

/*:
 And add it into the shader by:
 */
CanvasManager.canvas?.addObject(object: gouraudFragment3D)

/*:
 Any class confronts to `ObjectDrawProtocol2D` or `ObjectDrawProtocol3D` could be sent to the renderer.
 
 Now we just need to trigger a fresh render to see this fragment.

 > Run all codes above, click refresh button, and you should see a Gouraud colored fragment on the live view. Drag the image to see it in a different angle of view.
 */

/*:
 ### Textured Fragment
 
 A textured fragment can be created in the same way.
 Here we use two triangle fragments to create a rectangle.
 */

let basePoint = Vector3d(0, 0, 0.1)
let baseSize: Double = 2

let fragmentA = TextureFragment3D(pointA: basePoint,
pointB: basePoint + Vector3d(0, baseSize, 0),
pointC: basePoint + Vector3d(baseSize, 0, 0),
texImage: NSImage(imageLiteralResourceName: "grass.png"),
coordsA: .leftTop,
coordsB: .leftBottom,
coordsC: .rightTop)

let fragmentB = TextureFragment3D(pointA: basePoint + Vector3d(baseSize, baseSize, 0),
pointB: basePoint + Vector3d(0, baseSize, 0),
pointC: basePoint + Vector3d(baseSize, 0, 0),
texImage: NSImage(imageLiteralResourceName: "grass.png"),
coordsA: .rightBottom,
coordsB: .leftBottom,
coordsC: .rightTop)

/*:
2D Coordinate pairs are proivided to indicate how the texture should be mapped on the fragment.
 
 Now let's render it on the screen:
 */

CanvasManager.canvas?.addObject(object: fragmentA)
CanvasManager.canvas?.addObject(object: fragmentB)

/*:
 > Run all codes above, click refresh button, and you should see a texture mapped rectangle on the live view. Drag the image to see it in a different angle of view.
 */

/*:
 ### Lighting
 
 In order to render light effects, create `ShadingFragment3D` objects and lights, and render it.
 
We'd better remove all irrelevant fragments first.
 */
CanvasManager.canvas?.clearObject3D()
view.drawReferences()

/*:
 Then, we can add several fragments into our canvas:
 */

