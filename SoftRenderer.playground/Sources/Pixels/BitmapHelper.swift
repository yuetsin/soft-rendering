import Cocoa
import CoreGraphics

public class BitmapHelper {
    
    private static let rgbColorSpace = CGColorSpaceCreateDeviceRGB()

    public static func convertToBitmap(pixels: inout [Pixel], size: CGSize) -> NSImage? {
        let width = Int(size.width), height = Int(size.height)
        let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 4 * bitsPerComponent
        let bytesPerRow = bitsPerPixel * width / 8
        guard let providerRef = CGDataProvider(
            data: NSData(bytes: pixels, length: height * bytesPerRow)
        ) else { return nil }

        let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: bytesPerRow,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        return NSImage(cgImage: cgim!, size: size)
    }
}
