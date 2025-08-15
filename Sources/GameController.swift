import Cocoa

@MainActor
class GameController: NSObject {
    private var gameWindow: GameWindow!
    private var gameModel: GameModel!
    private var gameView: GameView!
    private var gameTimer: Timer?
    
    override init() {
        super.init()
        setupGame()
    }
    
    private func setupGame() {
        // ゲームモデルを初期化
        gameModel = GameModel()
        
        // ゲームウィンドウを作成
        gameWindow = GameWindow()
        
        // ゲームビューを作成
        gameView = GameView(frame: gameWindow.frame, gameModel: gameModel)
        gameWindow.contentView = gameView
        
        // ゲームビューにコントローラーを設定
        gameView.gameController = self
        
        // キー入力の設定
        gameWindow.makeFirstResponder(gameView)
    }
    
    func startGame() {
        gameWindow.makeKeyAndOrderFront(nil)
        gameWindow.center()
        
        // ゲームループを開始
        startGameLoop()
    }
    
    private func startGameLoop() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self = self else { return }
                if self.gameModel.isGameRunning {
                    self.gameModel.updateGame()
                    self.gameView.needsDisplay = true
                }
            }
        }
    }
    
    func stopGameLoop() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    // キー入力処理
    func handleKeyDown(with event: NSEvent) {
        guard gameModel.isGameRunning else {
            // ゲームが停止中の場合、スペースキーでリスタート
            if event.keyCode == 49 { // スペースキー
                restartGame()
            }
            return
        }
        
        switch event.keyCode {
        case 123: // 左矢印
            gameModel.player.moveLeft()
        case 124: // 右矢印
            gameModel.player.moveRight()
        case 53: // ESC
            NSApplication.shared.terminate(nil)
        default:
            break
        }
    }
    
    func handleKeyUp(with event: NSEvent) {
        guard gameModel.isGameRunning else { return }
        
        switch event.keyCode {
        case 123, 124: // 矢印キー
            gameModel.player.stopMoving()
        default:
            break
        }
    }
    
    func restartGame() {
        gameModel.restartGame()
        if gameTimer == nil {
            startGameLoop()
        }
    }
    
    func gameOver() {
        gameModel.gameOver()
        // ゲームオーバー時の処理（スコア表示など）
    }
}