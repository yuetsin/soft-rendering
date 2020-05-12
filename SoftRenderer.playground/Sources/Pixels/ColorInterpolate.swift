import Cocoa

@inlinable
public func ColorInterpolate(since: NSColor, till: NSColor, progress: CGFloat) -> NSColor {
    let redDiff = till.redComponent - since.redComponent
    let greenDiff = till.greenComponent - since.greenComponent
    let blueDiff = till.blueComponent - since.blueComponent
    let alphaDiff = till.alphaComponent - since.alphaComponent

    return NSColor(red: since.redComponent + progress * redDiff,
            green: since.greenComponent + progress * greenDiff,
            blue: since.blueComponent + progress * blueDiff,
            alpha: since.alphaComponent + progress * alphaDiff)
}
