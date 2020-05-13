import Cocoa

public func ColorInterpolate(since: CIColor, till: CIColor, interp: LinearInterpolate<Double>) -> CIColor {
    
    let progress = CGFloat(interp.u ?? 0)
    
    let redDiff = till.red - since.red
    let greenDiff = till.green - since.green
    let blueDiff = till.blue - since.blue
    let alphaDiff = till.alpha - since.alpha

    // due to precision issues, calculating result might exceed 0 or 1.
    // normalize it to avoid critical errors.
    return CIColor(red: (since.red + progress * redDiff).normalize(),
                   green: (since.green + progress * greenDiff).normalize(),
                   blue: (since.blue + progress * blueDiff).normalize(),
                   alpha: (since.alpha + progress * alphaDiff).normalize())
}

public func GouraudInterpolate(colorA: CIColor, colorB: CIColor, colorC: CIColor, interp: FragmentInterpolate<Double>) -> CIColor {
    
    let u = CGFloat(interp.u), v = CGFloat(interp.v), w = CGFloat(interp.w)

    let red = colorA.red * u + colorB.red * v + colorC.red * w
    let green = colorA.green * u + colorB.green * v + colorC.green * w
    let blue = colorA.blue * u + colorB.blue * v + colorC.blue * w
    let alpha = colorA.alpha * u + colorB.alpha * v + colorC.alpha * w

    return CIColor(red: red.normalize(), green: green.normalize(), blue: blue.normalize(), alpha: alpha.normalize())
}
