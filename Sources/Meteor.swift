import Foundation
import CoreGraphics

class Meteor: Obstacle {
    private var rotation: CGFloat = 0
    
    init(x: CGFloat, y: CGFloat) {
        super.init(x: x, y: y, width: 35, height: 35)
    }
    
    override func update(deltaTime: TimeInterval, speed: CGFloat) {
        super.update(deltaTime: deltaTime, speed: speed * 1.2) // 隕石は少し速い
        
        // 回転アニメーション
        rotation += CGFloat(deltaTime) * 3
    }
    
    var rotationAngle: CGFloat {
        return rotation
    }
}