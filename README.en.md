[English](./README.en.md) | [繁體中文](./README.md)

# [WWSafariViewUI](https://swiftpackageindex.com/William-Weng)

![SwiftUI](https://img.shields.io/badge/SwiftUI-524520?logo=swift)
[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSafariViewUI)
[![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

`WWSafariViewUI` is a lightweight SwiftUI wrapper around `SFSafariViewController`, allowing you to open web content with the native Safari experience directly inside your SwiftUI app without writing your own `UIViewControllerRepresentable` bridge.

https://github.com/William-Weng/WWSafariViewUI

## ✨ Features

- Opens web pages inside the app with `SFSafariViewController`, preserving Safari’s standard browsing experience and security.
- Provides a SwiftUI-friendly API that integrates naturally with `sheet`, `fullScreenCover`, and other presentation flows.
- Supports `entersReaderIfAvailable`, which automatically enters Reader mode when it is available for the page.
- Supports an `onFinish` callback so you can be notified when the Safari view is dismissed.

## 📦 Installation

### Swift Package Manager

In Xcode, choose:

- `File` > `Add Package Dependencies...`
- Enter your package Git URL
- Select a version and add it to your project

You can also add it manually in `Package.swift`:

```swift
.dependencies: [
    .package(url: "https://github.com/William-Weng/WWSafariViewUI.git", from: "1.0.0")
]
```

Then add the package product to your target:

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

Swift Package Manager is the official Swift tool for distributing and managing source code packages.

> Replace the Git URL, package name, and version with your real project information.

## 🚀 Quick Start

### Import the package

```swift
import SwiftUI
import WWSafariViewUI
```

### Basic usage

```swift
import SwiftUI
import WWSafariViewUI

struct ContentView: View {
    @State private var showSafari = false
    
    var body: some View {
        Button("Open Apple") {
            showSafari = true
        }
        .sheet(isPresented: $showSafari) {
            WWSafariViewUI(url: URL(string: "https://www.apple.com")!)
        }
    }
}
```

This is a great fit for help pages, privacy policies, support pages, and external article links when you want users to stay inside the app.

## 🎛️ Advanced Usage

### Automatically enter Reader mode

```swift
WWSafariViewUI(
    url: URL(string: "https://example.com/article")!,
    entersReaderIfAvailable: true
)
```

`entersReaderIfAvailable` only takes effect when Reader mode is available for the page, which is usually suitable for regular article pages rather than PDFs or raw Markdown files.

### Handle dismissal

```swift
WWSafariViewUI(
    url: URL(string: "https://www.apple.com")!,
    onFinish: {
        print("Safari was dismissed")
    }
)
```

When the user dismisses `SFSafariViewController`, the delegate receives a finish event, which you can use for cleanup or follow-up actions.

### Use with an item-based sheet

```swift
struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct ContentView: View {
    @State private var selectedURL: IdentifiableURL?
    
    var body: some View {
        Button("Open Website") {
            selectedURL = .init(url: URL(string: "https://developer.apple.com")!)
        }
        .sheet(item: $selectedURL) { item in
            WWSafariViewUI(url: item.url)
        }
    }
}
```

This pattern works well for lists, cards, bookmark screens, and other flows driven by optional presentation state.[web:247][web:309]

## 🧩 API

### Initializer

```swift
public init(
    url: URL,
    entersReaderIfAvailable: Bool = false,
    onFinish: (() -> Void)? = nil
)
```

| Parameter | Type | Description |
|---|---|---|
| `url` | `URL` | The web page URL to open. |
| `entersReaderIfAvailable` | `Bool` | Whether to automatically enter Reader mode when available. |
| `onFinish` | `(() -> Void)?` | A callback invoked when the Safari view is dismissed. |

## 🎯 Use Cases

`WWSafariViewUI` is suitable for:

- Opening external articles or official websites inside the app.
- Showing privacy policies, terms of service, and help pages.
- Quickly displaying bookmark, news, or document entry pages.

If you need full custom web interaction, JavaScript injection, or page-level control, `WKWebView` is a better fit. If you want the native Safari browsing experience, `SFSafariViewController` is usually the better choice.
