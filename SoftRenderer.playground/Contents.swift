import SwiftUI
import PlaygroundSupport
/*:
 # A Simple Software Renderer Demonstration
 
 ## Intro
  This is a toy software renderer written in pure Swift, featured with Gouraud shading, Z buffering, projection transforming, texture mapping, perspective correction, and Blinn-Phong lighting.

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
/*:
 Then, initialize our GUI based on `SwiftUI`.
 */
let size = CGSize(width: 800, height: 400)
let frame = CGRect(origin: .zero, size: size)
let hosting = NSHostingView(rootView: view)

hosting.frame = frame
PlaygroundPage.current.setLiveView(hosting)
/*:
 > Run all codes above, and we've got a `ControlPanelView` in our live view field.

 After clicking `Refresh` Button, the renderer will display a default space with three orthogonal directional lines, and a black-white translucent on $xOy$ plane.
 
 Camera position can be moved by dragging the rendering screen.

 ### 2D Fragments
 
 Creating a `Fragment2D` object and rendering it is easy in this way.
 */
let fragment2D = Fragment2D(
  pointA: Vector2d(40, 40),
  pointB: Vector2d(80, 80),
  pointC: Vector2d(60, 100),
  colorA: .red,
  colorB: .green,
  colorC: .blue)
CanvasManager.canvas?.addObject(object: fragment2D)
/*:

> Run all codes above, click refresh button, and you should see a 2D fragment directly on your screen.
 
> Any class conforms to `ObjectDrawProtocol2D` or `ObjectDrawProtocol3D` could be sent to the renderer.

 ### 3D Fragment
 
 Now we're going to 3D.
 
 First remove our earlier 2D fragments:
 */
CanvasManager.canvas?.clearObject2D()
/*:
 Creating a 3D fragment is easy: we can create a `Fragment3D` with Gouraud shading in this way:
 */
let gouraudFragment3D = GouraudFragment3D(
  pointA: Vector3d(2, -1, 0),
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
 > Run all codes above, click refresh button, and you should see a Gouraud colored fragment on the live view. Drag the image to see it in a different angle of view.
 */

/*:
 ### Textured Fragment
 
 A textured fragment can be created in the same way.
 Here we use two triangle fragments to create a rectangle.
 */

let basePoint = Vector3d(0, 0, 0.1)
let baseSize: Double = 2

/*:
2D Coordinate pairs are proivided to indicate how the texture should be mapped on the fragment.
 
Our texture mapping is a chessboard-like grass image:
*/

let textureMapping = NSImage(imageLiteralResourceName: "grass.png")
textureMapping

let fragmentA = TextureFragment3D(
  pointA: basePoint,
  pointB: basePoint + Vector3d(0, baseSize, 0),
  pointC: basePoint + Vector3d(baseSize, 0, 0),
  texImage: textureMapping,
  coordsA: .leftTop,
  coordsB: .leftBottom,
  coordsC: .rightTop)

let fragmentB = TextureFragment3D(
  pointA: basePoint + Vector3d(baseSize, baseSize, 0),
  pointB: basePoint + Vector3d(0, baseSize, 0),
  pointC: basePoint + Vector3d(baseSize, 0, 0),
  texImage: textureMapping,
  coordsA: .rightBottom,
  coordsB: .leftBottom,
  coordsC: .rightTop)

/*:
 Now let's render it on the screen:
 */
CanvasManager.canvas?.addObject(object: fragmentA)
CanvasManager.canvas?.addObject(object: fragmentB)
/*:
 > Run all codes above, click refresh button, and you should see a texture mapped rectangle on the live view. Drag the image to see it in a different angle of view.

 ### Lighting
 
 In order to render light effects, create `ShadingFragment3D` objects and lights, and render it.
 
We'd better remove all irrelevant fragments first.
 */
CanvasManager.canvas?.clearObject3D()
view.drawReferences()
/*:
 Then, we can add several fragments into our canvas:
 */
let shadingFragment3D1 = ShadingFragment3D(
  tPointA: Vector3d(2, -1, 0), tPointB: Vector3d(0, 0, 0), tPointC: Vector3d(1, 0, 2),
  material: Material(shininess: 0.8, color: .red))
let shadingFragment3D2 = ShadingFragment3D(
  tPointA: Vector3d(1, 0, -1), tPointB: Vector3d(-1, -1, -1), tPointC: Vector3d(1, -1, 1),
  material: Material(shininess: 0.8, color: .blue))
CanvasManager.canvas?.addObject(object: shadingFragment3D1)
CanvasManager.canvas?.addObject(object: shadingFragment3D2)
/*:
 > If we execute code till here and try to render the scene, there will be no lighting effect since we haven't add any light in our scene.

 
 So now let's try three different kind of lightings here:
 */
CanvasManager.canvas?.worldLights.append(defaultDirectionalLight)
/*:
> Execute code till here and click `Refresh` button to see the effect of directional light.
*/
CanvasManager.canvas?.worldLights.append(defaultPointLight)
/*:
> Execute code till here and click `Refresh` button to see the effect of point light.
*/
CanvasManager.canvas?.worldLights.append(defaultSpotLight)
/*:
> Execute code till here and click `Refresh` button to see the effect of spot light.
*/
/*:
 ### Perspective Correction
 
 In this simple rendering engine, all `Objects3D` contains world coordinates. They can't be directly rendered on screen without a critical process called `Projection`.
 
 However, if we do the interpolation without doing correction, the texture will be so incorrect since after the projection, those screen coordinates doesn't keep original scalable relations. Here's ther result without perspective correction:
 */
CanvasManager.canvas?.clearWorldLights()
CanvasManager.canvas?.clearObject3D()
view.drawReferences()

let fragmentC = TextureFragment3D(
  pointA: basePoint,
  pointB: basePoint + Vector3d(0, -baseSize, 0),
  pointC: basePoint + Vector3d(-baseSize, 0, 0),
  texImage: textureMapping,
  coordsA: .leftTop,
  coordsB: .leftBottom,
  coordsC: .rightTop,
  perspCorrect: false)

let fragmentD = TextureFragment3D(
  pointA: basePoint + Vector3d(-baseSize, -baseSize, 0),
  pointB: basePoint + Vector3d(0, -baseSize, 0),
  pointC: basePoint + Vector3d(-baseSize, 0, 0),
  texImage: textureMapping,
  coordsA: .rightBottom,
  coordsB: .leftBottom,
  coordsC: .rightTop,
  perspCorrect: false)

CanvasManager.canvas?.addObject(object: fragmentA)
CanvasManager.canvas?.addObject(object: fragmentB)
CanvasManager.canvas?.addObject(object: fragmentC)
CanvasManager.canvas?.addObject(object: fragmentD)
/*:
> Run all codes above, click refresh button, and you can tell the difference between with and without perspective correction.
 */
