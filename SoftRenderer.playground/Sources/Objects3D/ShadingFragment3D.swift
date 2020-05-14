import Cocoa

public class ShadingFragment3D: ObjectDrawProtocol3D {
    
    var tPointA, tPointB, tPointC: Vector3d!
    var material: Material!
    
    public init(tPointA: Vector3d, tPointB: Vector3d, tPointC: Vector3d, material: Material) {
        self.tPointA = tPointA
        self.tPointB = tPointB
        self.tPointC = tPointC
        self.material = material
    }

    public func drawOn(target pixels: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double], lights: inout [Light], camera: Camera<Double>) {
        
        let normal = ((tPointB - tPointA).cross(with: tPointC - tPointA))
        let tColorA = renderLight(lights: lights, material: self.material, camera: camera, position: tPointA, normal: normal)
        let tColorB = renderLight(lights: lights, material: self.material, camera: camera, position: tPointB, normal: normal)
        let tColorC = renderLight(lights: lights, material: self.material, camera: camera, position: tPointC, normal: normal)
        
        let pA = transformPoint(point: tPointA, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))
        let pB = transformPoint(point: tPointB, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))
        let pC = transformPoint(point: tPointC, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))
        
        
        rasterize(canvasWidth: Double(canvasSize.width), canvasHeight: Double(canvasSize.height), pA: pA, pB: pB, pC: pC, handler: { point, interp in
            var pixel: Pixel!
            
            if getZBuffer(zBuffer: &depthBuffer, x: point.x, y: point.y, size: canvasSize) ?? Double.infinity >= point.z {
                
                let color = GouraudInterpolateWithCorrection(colorA: tColorA,
                                                             colorB: tColorB,
                                                             colorC: tColorC,
                                                             interp: interp,
                                                             zA: pA.z, zB: pB.z, zC: pC.z, refZ: point.z)
                
                pixel = color2Pixel(color: color)
                
                putPixel(pixels: &pixels, x: point.x, y: point.y, size: canvasSize, target: pixel)
                putZBuffer(zBuffer: &depthBuffer, x: point.x, y: point.y, size: canvasSize, target: point.z)
            }
        })
    }
}
