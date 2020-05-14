import Cocoa


public func LinearColorInterpolate(since: CIColor, till: CIColor, interp: LinearInterpolate<Double>) -> CIColor {
    
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
