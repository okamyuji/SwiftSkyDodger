import Foundation
import CoreGraphics

class Cloud: Obstacle {
    init(x: CGFloat, y: CGFloat) {
        super.init(x: x, y: y, width: 60, height: 30)
    }
}