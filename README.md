# SwiftSkyDodger 🚀

SwiftSkyDodgerは、Swiftで作られたmacOS向けの楽しい回避ゲームです。プレイヤーが飛行機を操縦し、空から降ってくる障害物を避けながらスコアを稼ぐアクションゲームです。シンプルながら中毒性のあるゲームプレイが特徴です。

![Swift](https://img.shields.io/badge/Swift-5.8+-orange.svg)
![Platform](https://img.shields.io/badge/Platform-macOS-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 🎮 ゲームコンセプト

- **ジャンル**: アクション・回避ゲーム
- **プラットフォーム**: macOS (Swift + AppKit)
- **操作**: キーボード操作（矢印キー）
- **目標**: 障害物を避けて最高スコアを目指す

## 🚁 ゲームプレイ

1. プレイヤーは画面下部の飛行機を左右に操縦
2. 空から雲、鳥、隕石などの障害物が降ってくる
3. 障害物に当たるとゲームオーバー
4. 時間が経つほど障害物の速度と密度が増加
5. 避けた障害物の数がスコアになる

## ✨ ゲームの特徴

- **シンプルで中毒性のあるゲームプレイ**: 矢印キーで飛行機を操縦し、障害物を避ける
- **3種類の障害物**: 雲、鳥（羽ばたきアニメーション）、隕石（回転アニメーション）
- **美しいグラフィック**: Core Graphicsによる滑らかな2D描画
- **難易度調整**: 時間経過とともに障害物の速度と密度が増加
- **スコアシステム**: 避けた障害物の数でスコアを競う
- **60FPSアニメーション**: 滑らかで美しい動作

## 🎯 操作方法

- **←→ 矢印キー**: プレイヤーの左右移動
- **スペースキー**: ゲーム開始/リスタート
- **ESC キー**: ゲーム終了

## 🎨 UI要素

- **スコア表示**: 画面上部に現在のスコア
- **レベル表示**: 現在の難易度レベル
- **ゲームオーバー画面**: スコアとリスタートオプション
- **スタート画面**: ゲーム説明と開始ボタン

## 📋 システム要件

- **macOS**: 10.15 (Catalina) 以上
- **Xcode**: 12.0 以上
- **Swift**: 5.8 以上
- **Swift Package Manager**: 対応

## 🚀 インストールと実行手順

### 1. リポジトリをクローン

```bash
git clone https://github.com/your-username/SwiftSkyDodger.git
cd SwiftSkyDodger
```

### 2. 必要な開発ツールの確認

Xcodeとコマンドラインツールがインストールされていることを確認してください：

```bash
# Xcodeコマンドラインツールの確認
xcode-select --print-path

# Swiftバージョンの確認
swift --version
```

### 3. プロジェクトのビルド

Swift Package Managerを使用してプロジェクトをビルドします：

```bash
# デバッグビルド
swift build

# リリースビルド（最適化済み）
swift build -c release
```

### 4. ゲームの実行

ビルドが完了したら、以下のコマンドでゲームを起動できます：

```bash
# デバッグ版の実行
.build/debug/SwiftSkyDodger

# リリース版の実行（ビルドした場合）
.build/release/SwiftSkyDodger
```

### 5. Xcodeでの開発（オプション）

Xcodeでプロジェクトを開いて開発したい場合：

```bash
# Xcodeプロジェクトを生成して開く
swift package generate-xcodeproj
open SwiftSkyDodger.xcodeproj
```

または、Xcode 11以降では直接Package.swiftを開くことができます：

```bash
open Package.swift
```

## ⚡ クイックスタート

最速でゲームを試したい場合：

```bash
git clone https://github.com/your-username/SwiftSkyDodger.git
cd SwiftSkyDodger
swift build && .build/debug/SwiftSkyDodger
```

## 🛠 トラブルシューティング

### ビルドエラーが発生した場合

1. **Swift バージョンの確認**:

   ```bash
   swift --version
   ```

   Swift 5.8以上が必要です。

2. **ビルドキャッシュのクリア**:

   ```bash
   swift package clean
   swift build
   ```

3. **Xcodeコマンドラインツールの再インストール**:

   ```bash
   sudo xcode-select --install
   ```

### ゲームが起動しない場合

1. **macOSバージョンの確認**: macOS 10.15以上が必要です
2. **実行権限の確認**:

   ```bash
   chmod +x .build/debug/SwiftSkyDodger
   ```

## 🏗 プロジェクト構造

```text
SwiftSkyDodger/
├── README.md              # このファイル
├── LICENSE                # MITライセンス
├── Package.swift          # Swift Package設定
└── Sources/
    ├── main.swift         # エントリーポイント
    ├── GameController.swift # メインゲーム制御
    ├── GameModel.swift    # ゲーム状態管理
    ├── GameView.swift     # 描画処理
    ├── GameWindow.swift   # ウィンドウ管理
    ├── Player.swift       # プレイヤークラス
    ├── Obstacle.swift     # 障害物基底クラス
    ├── Cloud.swift        # 雲障害物
    ├── Bird.swift         # 鳥障害物
    └── Meteor.swift       # 隕石障害物
```

## 🔧 技術仕様

### アーキテクチャ

- **MVC パターン** を採用
- **Model**: ゲーム状態、プレイヤー、障害物の管理
- **View**: ゲーム描画とUI表示
- **Controller**: ユーザー入力とゲームロジックの制御

### 主要クラス設計

#### 1. GameController

- ゲーム全体の制御
- メインゲームループの管理
- 入力処理

#### 2. Player

- プレイヤーの位置と状態
- 移動処理
- 衝突判定

#### 3. Obstacle

- 障害物の基底クラス
- 種類：雲(Cloud), 鳥(Bird), 隕石(Meteor)
- 移動と描画処理

#### 4. GameView

- NSViewを継承したカスタムビュー
- ゲーム画面の描画
- 背景、プレイヤー、障害物の描画

#### 5. GameModel

- ゲーム状態の管理
- スコア、レベル、ゲームオーバー状態
- 障害物の生成と管理

### 描画とアニメーション

- **Core Graphics** を使用した2D描画
- **NSTimer** を使用したアニメーションループ
- 60FPSでの滑らかな動作

### ゲームバランス

- **初期速度**: 障害物は毎秒50ピクセル降下
- **加速**: 10秒ごとに速度10%増加
- **障害物生成**: 初期は2秒間隔、徐々に短縮
- **プレイヤー速度**: 毎秒200ピクセル移動

## 🎨 技術詳細

- **言語**: Swift 6.1
- **フレームワーク**: AppKit, Core Graphics
- **アーキテクチャ**: MVC (Model-View-Controller)
- **並行性**: MainActor を使用した適切な UI スレッド管理
- **アニメーション**: 60FPS でのスムーズな描画

## 🚀 将来の拡張案

- パワーアップアイテム
- 複数の背景テーマ
- サウンドエフェクト
- ハイスコアランキング
- マルチプレイヤーモード

## 🤝 コントリビューション

バグ報告や機能提案はIssueからお願いします。プルリクエストも歓迎します！

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は [LICENSE](LICENSE) ファイルをご覧ください。
