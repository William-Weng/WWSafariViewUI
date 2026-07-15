[English](./README.en.md) | [繁體中文](./README.md)

# [WWSafariViewUI](https://swiftpackageindex.com/William-Weng)

![SwiftUI](https://img.shields.io/badge/SwiftUI-524520?logo=swift)
[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSafariViewUI)
[![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

`WWSafariViewUI` 是一個以 SwiftUI 包裝 `SFSafariViewController` 的輕量元件，讓你可以直接在 SwiftUI 專案中，用原生 Safari 體驗開啟網頁內容，而不需要自行撰寫 `UIViewControllerRepresentable` 橋接程式。

https://github.com/user-attachments/assets/0129c35d-d86d-4a6d-9b93-f3b14c9103be

## ✨ 功能特色

- 使用 `SFSafariViewController` 在 App 內開啟網頁，保留 Safari 的標準瀏覽體驗與安全性。
- 提供 SwiftUI 友善的 API，直接以 `View` 方式整合到 `sheet`、`fullScreenCover` 等畫面流程中。
- 支援 `entersReaderIfAvailable`，在 Safari Reader 模式可用時自動進入閱讀模式。
- 支援 `onFinish` 回呼，可在使用者關閉 Safari 畫面時收到通知。

## 📦 安裝方式

### Swift Package Manager

在 Xcode 中選擇：

- `File` > `Add Package Dependencies...`
- 輸入你的套件 Git URL
- 選擇版本後加入專案

也可以手動加入 `Package.swift`：

```swift
.dependencies: [
    .package(url: "https://github.com/William-Weng/WWSafariViewUI.git", from: "1.1.0")
]
```

接著把套件產品加入 target：

```swift
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "WWSafariViewUI", package: "WWSafariViewUI")
        ]
    )
]
```

## 🚀 快速開始

### 匯入套件

```swift
import SwiftUI
import WWSafariViewUI
```

### 基本用法

```swift
import SwiftUI
import WWSafariViewUI

struct ContentView: View {
    @State private var showSafari = false
    
    var body: some View {
        Button("開啟 Apple") {
            showSafari = true
        }
        .sheet(isPresented: $showSafari) {
            WWSafariViewUI(url: URL(string: "https://www.apple.com")!)
        }
    }
}
```

這種用法很適合用在說明頁、隱私權政策、幫助中心或外部文章連結，讓使用者不需要離開 App 就能瀏覽內容。

## 🎛️ 進階用法

### 自動進入閱讀模式

```swift
WWSafariViewUI(
    url: URL(string: "https://example.com/article")!,
    entersReaderIfAvailable: true
)
```

`entersReaderIfAvailable` 只有在 Safari Reader 模式支援該頁面時才會生效，通常適合一般文章頁，而不是 PDF 或原始 Markdown 檔案。

### 監聽事件

```swift
struct ContentView: View {
    
    @State private var showSafari = false
    
    var body: some View {
        Button("開啟 Apple") {
            showSafari = true
        }
        .sheet(isPresented: $showSafari) {
            WWSafariViewUI(url: URL(string: "https://www.apple.com")!)
                .onLoadComplete({ controller, didLoadSuccessfully in
                    print(didLoadSuccessfully)
                })
                .onFinish { controller in
                    print(controller)
                }
        }
    }
}
```

當使用者關閉 `SFSafariViewController` 時，delegate 會收到完成事件，你可以在這裡做收尾處理。

### 搭配 item-based sheet

```swift
struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct ContentView: View {
    @State private var selectedURL: IdentifiableURL?
    
    var body: some View {
        Button("開啟網站") {
            selectedURL = .init(url: URL(string: "https://developer.apple.com")!)
        }
        .sheet(item: $selectedURL) { item in
            WWSafariViewUI(url: item.url)
        }
    }
}
```

這種寫法很適合和列表、卡片、書籤頁等情境搭配，能用狀態直接驅動畫面呈現。

## 🧩 API

### 初始化

```swift
public init(
    url: URL,
    entersReaderIfAvailable: Bool = false
)
```

| 參數 | 型別 | 說明 |
|---|---|---|
| `url` | `URL` | 要開啟的網址。 |
| `entersReaderIfAvailable` | `Bool` | 是否在支援時自動進入閱讀器模式。 |
| `onLoadComplete` | `((controller, didLoadSuccessfully) -> Void)?` | Safari 載入完成時的回呼變數。 |
| `onFinish` | `((controller) -> Void)?` | Safari 畫面關閉時執行的回呼。 |

## 🎯 使用情境

`WWSafariViewUI` 適合以下場景：

- App 內開啟外部文章或官方網站
- 顯示隱私權政策、服務條款、幫助中心
- 書籤、新聞、文件入口頁等需要快速開網頁的功能

如果你需要的是完整自訂網頁互動、注入 JavaScript 或控制瀏覽內容，`WKWebView` 會更適合；如果你要的是系統原生 Safari 體驗，`SFSafariViewController` 會是更好的選擇。

