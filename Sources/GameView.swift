import Cocoa
import CoreGraphics

class GameView: NSView {
    var gameModel: GameModel
    var gameController: GameController?
    
    init(frame frameRect: NSRect, gameModel: GameModel) {
        self.gameModel = gameModel
        super.init(frame: frameRect)
        
        // ビューがキー入力を受け取れるようにする
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let context = NSGraphicsContext.current?.cgContext else { return }
        
        // 背景を描画
        drawBackground(context: context)
        
        if !gameModel.gameStarted {
            // スタート画面を描画
            drawStartScreen(context: context)
        } else if gameModel.isGameRunning {
            // ゲームプレイ中の描画
            drawGameplay(context: context)
        } else {
            // ゲームオーバー画面を描画
            drawGameOverScreen(context: context)
        }
    }
    
    private func drawBackground(context: CGContext) {
        // 空のグラデーション背景
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let topColor = CGColor(red: 0.5, green: 0.8, blue: 1.0, alpha: 1.0)
        let bottomColor = CGColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        
        let colors = [topColor, bottomColor]
        let locations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else { return }
        
        context.drawLinearGradient(
            gradient,
            start: CGPoint(x: 0, y: bounds.height),
            end: CGPoint(x: 0, y: 0),
            options: []
        )
    }
    
    private func drawStartScreen(context: CGContext) {
        let titleText = "SwiftSkyDodger"
        let instructionText = "矢印キーで飛行機を操縦し、障害物を避けよう！"
        let startText = "スペースキーでスタート"
        
        // タイトル
        context.setFillColor(CGColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 1.0))
        drawText(titleText, at: CGPoint(x: bounds.width / 2, y: bounds.height * 0.7), fontSize: 48, context: context, centered: true)
        
        // 説明
        context.setFillColor(CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0))
        drawText(instructionText, at: CGPoint(x: bounds.width / 2, y: bounds.height * 0.5), fontSize: 18, context: context, centered: true)
        
        // スタート
        context.setFillColor(CGColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0))
        drawText(startText, at: CGPoint(x: bounds.width / 2, y: bounds.height * 0.3), fontSize: 24, context: context, centered: true)
    }
    
    private func drawGameplay(context: CGContext) {
        // プレイヤーを描画
        drawPlayer(context: context)
        
        // 障害物を描画
        for obstacle in gameModel.obstacles {
            if let cloud = obstacle as? Cloud {
                drawCloud(cloud: cloud, context: context)
            } else if let bird = obstacle as? Bird {
                drawBird(bird: bird, context: context)
            } else if let meteor = obstacle as? Meteor {
                drawMeteor(meteor: meteor, context: context)
            }
        }
        
        // UI要素を描画
        drawUI(context: context)
    }
    
    private func drawGameOverScreen(context: CGContext) {
        // ゲームプレイの内容も薄く表示
        context.setAlpha(0.5)
        drawGameplay(context: context)
        context.setAlpha(1.0)
        
        // ゲームオーバー画面
        let gameOverText = "ゲームオーバー"
        let scoreText = "スコア: \(gameModel.score)"
        let restartText = "スペースキーでリスタート"
        
        // 背景矩形
        context.setFillColor(CGColor(red: 0, green: 0, blue: 0, alpha: 0.7))
        let rect = CGRect(x: bounds.width * 0.2, y: bounds.height * 0.3, width: bounds.width * 0.6, height: bounds.height * 0.4)
        context.fill(rect)
        
        // テキスト
        context.setFillColor(CGColor(red: 1, green: 0.2, blue: 0.2, alpha: 1.0))
        drawText(gameOverText, at: CGPoint(x: bounds.width / 2, y: bounds.height * 0.6), fontSize: 36, context: context, centered: true)
        
        context.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 1.0))
        drawText(scoreText, at: CGPoint(x: bounds.width / 2, y: bounds.height * 0.5), fontSize: 24, context: context, centered: true)
        drawText(restartText, at: CGPoint(x: bounds.width / 2, y: bounds.height * 0.4), fontSize: 18, context: context, centered: true)
    }
    
    private func drawPlayer(context: CGContext) {
        let player = gameModel.player
        
        // 飛行機の描画（簡単な三角形）
        context.setFillColor(CGColor(red: 0.2, green: 0.6, blue: 0.2, alpha: 1.0))
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: player.x, y: player.y + player.height / 2))
        path.addLine(to: CGPoint(x: player.x - player.width / 2, y: player.y - player.height / 2))
        path.addLine(to: CGPoint(x: player.x + player.width / 2, y: player.y - player.height / 2))
        path.closeSubpath()
        
        context.addPath(path)
        context.fillPath()
    }
    
    private func drawCloud(cloud: Cloud, context: CGContext) {
        context.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.8))
        
        // 雲を複数の円で表現
        let numCircles = 4
        for i in 0..<numCircles {
            let offset = CGFloat(i - numCircles / 2) * cloud.width / CGFloat(numCircles)
            let radius = cloud.height / 2 * (0.8 + 0.2 * sin(CGFloat(i)))
            let circle = CGRect(
                x: cloud.x + offset - radius,
                y: cloud.y - radius,
                width: radius * 2,
                height: radius * 2
            )
            context.fillEllipse(in: circle)
        }
    }
    
    private func drawBird(bird: Bird, context: CGContext) {
        context.setFillColor(CGColor(red: 0.3, green: 0.2, blue: 0.1, alpha: 1.0))
        
        // 鳥の体（楕円）
        let bodyRect = CGRect(
            x: bird.x - bird.width / 3,
            y: bird.y - bird.height / 2,
            width: bird.width / 1.5,
            height: bird.height
        )
        context.fillEllipse(in: bodyRect)
        
        // 翼（羽ばたきアニメーション）
        let wingOffset = sin(bird.wingPhaseValue) * 3
        context.setFillColor(CGColor(red: 0.4, green: 0.3, blue: 0.2, alpha: 1.0))
        
        // 左翼
        let leftWing = CGRect(
            x: bird.x - bird.width / 2,
            y: bird.y + wingOffset - 2,
            width: bird.width / 3,
            height: 4
        )
        context.fillEllipse(in: leftWing)
        
        // 右翼
        let rightWing = CGRect(
            x: bird.x + bird.width / 6,
            y: bird.y - wingOffset - 2,
            width: bird.width / 3,
            height: 4
        )
        context.fillEllipse(in: rightWing)
    }
    
    private func drawMeteor(meteor: Meteor, context: CGContext) {
        context.setFillColor(CGColor(red: 0.7, green: 0.3, blue: 0.1, alpha: 1.0))
        
        // 回転を適用
        context.saveGState()
        context.translateBy(x: meteor.x, y: meteor.y)
        context.rotate(by: meteor.rotationAngle)
        
        // 隕石（菱形）
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: meteor.height / 2))
        path.addLine(to: CGPoint(x: -meteor.width / 2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: -meteor.height / 2))
        path.addLine(to: CGPoint(x: meteor.width / 2, y: 0))
        path.closeSubpath()
        
        context.addPath(path)
        context.fillPath()
        
        context.restoreGState()
    }
    
    private func drawUI(context: CGContext) {
        // スコア表示
        let scoreText = "スコア: \(gameModel.score)"
        context.setFillColor(CGColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 1.0))
        drawText(scoreText, at: CGPoint(x: 20, y: bounds.height - 30), fontSize: 18, context: context)
        
        // レベル表示
        let levelText = "レベル: \(gameModel.level)"
        drawText(levelText, at: CGPoint(x: 20, y: bounds.height - 55), fontSize: 16, context: context)
    }
    
    private func drawText(_ text: String, at point: CGPoint, fontSize: CGFloat, context: CGContext, centered: Bool = false) {
        let font = NSFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: NSColor.black
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        let textSize = attributedString.size()
        
        var drawPoint = point
        if centered {
            drawPoint.x -= textSize.width / 2
            drawPoint.y -= textSize.height / 2
        }
        
        // Cocoa座標系に変換（Y軸が逆）
        drawPoint.y = bounds.height - drawPoint.y - textSize.height
        
        attributedString.draw(at: drawPoint)
    }
    
    // キー入力処理
    override func keyDown(with event: NSEvent) {
        if !gameModel.gameStarted {
            if event.keyCode == 49 { // スペースキー
                gameModel.startGame()
                return
            }
        }
        
        gameController?.handleKeyDown(with: event)
    }
    
    override func keyUp(with event: NSEvent) {
        gameController?.handleKeyUp(with: event)
    }
}