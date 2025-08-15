import Foundation
import CoreGraphics

class Player {
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat = 40
    var height: CGFloat = 30
    var speed: CGFloat = 200 // ピクセル/秒
    
    private var velocityX: CGFloat = 0
    private let gameWidth: CGFloat
    
    init(x: CGFloat, y: CGFloat, gameWidth: CGFloat) {
        self.x = x
        self.y = y
        self.gameWidth = gameWidth
    }
    
    func moveLeft() {
        velocityX = -speed
    }
    
    func moveRight() {
        velocityX = speed
    }
    
    func stopMoving() {
        velocityX = 0
    }
    
    func update(deltaTime: TimeInterval) {
        // 位置を更新
        x += velocityX * CGFloat(deltaTime)
        
        // 画面境界でクランプ
        x = max(width / 2, min(gameWidth - width / 2, x))
    }
    
    func checkCollision(with obstacle: Obstacle) -> Bool {
        let playerRect = CGRect(
            x: x - width / 2,
            y: y - height / 2,
            width: width,
            height: height
        )
        
        let obstacleRect = CGRect(
            x: obstacle.x - obstacle.width / 2,
            y: obstacle.y - obstacle.height / 2,
            width: obstacle.width,
            height: obstacle.height
        )
        
        return playerRect.intersects(obstacleRect)
    }
    
    func reset(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
        self.velocityX = 0
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