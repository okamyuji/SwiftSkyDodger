import Foundation
import CoreGraphics

class Obstacle {
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    func update(deltaTime: TimeInterval, speed: CGFloat) {
        y -= speed * CGFloat(deltaTime)
    }
    
    var rect: CGRect {
        return CGRect(
            x: x - width / 2,
            y: y - height / 2,
            width: width,
            height: height
        )
    }
}