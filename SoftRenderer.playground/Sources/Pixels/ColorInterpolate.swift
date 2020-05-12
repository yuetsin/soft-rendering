import Cocoa

@inlinable
public func ColorInterpolate(since nsSince: NSColor, till nsTill: NSColor, progress: CGFloat) -> NSColor {
    let since = CIColor(color: nsSince)!
    let till = CIColor(color: nsTill)!
    
    let redDiff = till.red - since.red
    let greenDiff = till.green - since.green
    let blueDiff = till.blue - since.blue
    let alphaDiff = till.alpha - since.alpha

    return NSColor(red: since.red + progress * redDiff,
            green: since.green + progress * greenDiff,
            blue: since.blue + progress * blueDiff,
            alpha: since.alpha + progress * alphaDiff)
}
