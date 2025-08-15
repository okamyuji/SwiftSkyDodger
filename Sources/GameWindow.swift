import Cocoa

class GameWindow: NSWindow {
    
    init() {
        let contentRect = NSRect(x: 0, y: 0, width: 800, height: 600)
        
        super.init(
            contentRect: contentRect,
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        
        self.title = "SwiftSkyDodger"
        self.isReleasedWhenClosed = false
        
        // ウィンドウが閉じられた時の処理
        self.delegate = self
    }
}

extension GameWindow: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(nil)
        return true
    }
}