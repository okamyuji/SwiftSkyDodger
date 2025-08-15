import Foundation
import CoreGraphics

class GameModel {
    var player: Player
    var obstacles: [Obstacle] = []
    var score: Int = 0
    var level: Int = 1
    var isGameRunning: Bool = false
    var gameStarted: Bool = false
    
    // ゲーム設定
    var obstacleSpeed: CGFloat = 50.0 // 初期速度（ピクセル/秒）
    var obstacleSpawnInterval: TimeInterval = 2.0 // 初期生成間隔
    private var lastObstacleSpawn: TimeInterval = 0
    private var gameStartTime: TimeInterval = 0
    private var lastUpdateTime: TimeInterval = 0
    
    // ゲーム領域のサイズ
    let gameWidth: CGFloat = 800
    let gameHeight: CGFloat = 600
    
    init() {
        player = Player(x: gameWidth / 2, y: 50, gameWidth: gameWidth)
        gameStartTime = Date().timeIntervalSince1970
        lastUpdateTime = gameStartTime
    }
    
    func startGame() {
        isGameRunning = true
        gameStarted = true
        gameStartTime = Date().timeIntervalSince1970
        lastUpdateTime = gameStartTime
        lastObstacleSpawn = gameStartTime
    }
    
    func updateGame() {
        let currentTime = Date().timeIntervalSince1970
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        // プレイヤーの更新
        player.update(deltaTime: deltaTime)
        
        // 障害物の生成
        spawnObstacles(currentTime: currentTime)
        
        // 障害物の更新
        updateObstacles(deltaTime: deltaTime)
        
        // 衝突判定
        checkCollisions()
        
        // レベルとスピードの更新
        updateDifficulty(gameTime: currentTime - gameStartTime)
        
        // 画面外の障害物を削除してスコア加算
        removeOffscreenObstacles()
    }
    
    private func spawnObstacles(currentTime: TimeInterval) {
        if currentTime - lastObstacleSpawn >= obstacleSpawnInterval {
            let obstacleType = Int.random(in: 0...2)
            let x = CGFloat.random(in: 30...(gameWidth - 30))
            
            let obstacle: Obstacle
            switch obstacleType {
            case 0:
                obstacle = Cloud(x: x, y: gameHeight)
            case 1:
                obstacle = Bird(x: x, y: gameHeight)
            default:
                obstacle = Meteor(x: x, y: gameHeight)
            }
            
            obstacles.append(obstacle)
            lastObstacleSpawn = currentTime
        }
    }
    
    private func updateObstacles(deltaTime: TimeInterval) {
        for obstacle in obstacles {
            obstacle.update(deltaTime: deltaTime, speed: obstacleSpeed)
        }
    }
    
    private func checkCollisions() {
        for obstacle in obstacles {
            if player.checkCollision(with: obstacle) {
                gameOver()
                return
            }
        }
    }
    
    private func updateDifficulty(gameTime: TimeInterval) {
        // 10秒ごとに速度を10%増加
        let newLevel = Int(gameTime / 10) + 1
        if newLevel > level {
            level = newLevel
            obstacleSpeed *= 1.1
            obstacleSpawnInterval = max(0.5, obstacleSpawnInterval * 0.9) // 最小0.5秒間隔
        }
    }
    
    private func removeOffscreenObstacles() {
        let initialCount = obstacles.count
        obstacles.removeAll { obstacle in
            if obstacle.y < -50 {
                // 画面外に出た障害物はスコアに加算
                return true
            }
            return false
        }
        
        // 削除された障害物の数だけスコアを加算
        let removedCount = initialCount - obstacles.count
        score += removedCount
    }
    
    func gameOver() {
        isGameRunning = false
    }
    
    func restartGame() {
        player.reset(x: gameWidth / 2, y: 50)
        obstacles.removeAll()
        score = 0
        level = 1
        obstacleSpeed = 50.0
        obstacleSpawnInterval = 2.0
        
        let currentTime = Date().timeIntervalSince1970
        gameStartTime = currentTime
        lastUpdateTime = currentTime
        lastObstacleSpawn = currentTime
        
        isGameRunning = true
    }
}