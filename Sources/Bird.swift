import Foundation
import CoreGraphics

class Bird: Obstacle {
    private var wingPhase: CGFloat = 0
    
    init(x: CGFloat, y: CGFloat) {
        super.init(x: x, y: y, width: 25, height: 20)
    }
    
    override func update(deltaTime: TimeInterval, speed: CGFloat) {
        super.update(deltaTime: deltaTime, speed: speed)
        
        // 羽ばたきアニメーション
        wingPhase += CGFloat(deltaTime) * 10
        
        // 少し左右に動く
        x += sin(wingPhase) * 20 * CGFloat(deltaTime)
    }
    
    var wingPhaseValue: CGFloat {
        return wingPhase
    }
}