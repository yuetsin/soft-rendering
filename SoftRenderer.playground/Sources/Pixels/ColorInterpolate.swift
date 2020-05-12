import Cocoa

@inlinable
public func ColorInterpolate(since nsSince: NSColor, till nsTill: NSColor, progress: CGFloat) -> NSColor {
    let since = CIColor(color: nsSince)!
    let till = CIColor(color: nsTill)!

    let redDiff = till.red - since.red
    let greenDiff = till.green - since.green
    let blueDiff = till.blue - since.blue
    let alphaDiff = till.alpha - since.alpha

    return NSColor(red: min(1, max(0, since.red + progress * redDiff)),
                   green: min(1, max(0, since.green + progress * greenDiff)),
                   blue: min(1, max(0, since.blue + progress * blueDiff)),
                   alpha: min(1, max(0, since.alpha + progress * alphaDiff)))
}

@inlinable
public func GouraudInterpolate(at P: Point2d,
                               pointA P1: Point2d, pointB P2: Point2d, pointC P3: Point2d,
                               nsColorA: NSColor, nsColorB: NSColor, nsColorC: NSColor) -> NSColor {
    let u = CGFloat(-((P.y - P1.y * (P1.x - P3.x) - (P.x - P1.x) * (P1.y - P3.y)) / ((P1.y - P2.y) * (P1.x - P3.x) - (P1.x - P2.x) * (P1.y - P3.y))))
    let v = CGFloat(-((-P.y * P1.x + P.x * P1.y + P.y * P2.x - P1.y * P2.x - P.x * P2.y + P1.x * P2.y) / (P1.y * P2.x - P1.x * P2.y - P1.y * P3.x + P2.y * P3.x + P1.x * P3.y - P2.x * P3.y)))

    let w = 1 - u - v

    let ciColorA = CIColor(color: nsColorA)!
    let ciColorB = CIColor(color: nsColorB)!
    let ciColorC = CIColor(color: nsColorC)!

    let red = min(1, max(0, ciColorA.red * u + ciColorB.red * v + ciColorC.red * w))
    let green = min(1, max(0, ciColorA.green * u + ciColorB.green * v + ciColorC.green * w))
    let blue = min(1, max(0, ciColorA.blue * u + ciColorB.blue * v + ciColorC.blue * w))
    let alpha = min(1, max(0, ciColorA.alpha * u + ciColorB.alpha * v + ciColorC.alpha * w))

    return NSColor(red: red, green: green, blue: blue, alpha: alpha)
}
