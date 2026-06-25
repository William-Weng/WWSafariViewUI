//
//  WWSafariViewUI.swift
//  WWSafariViewUI
//
//  Created by William.Weng on 2026/6/25.
//

import SwiftUI
import SafariServices

/// SwiftUI 包裝的 Safari 網頁畫面
///
/// 此視圖使用 `SFSafariViewController` 在 App 內顯示指定網址，適合用於快速開啟外部網頁內容，同時保留 Safari 的標準瀏覽體驗
public struct WWSafariViewUI {
    
    let url: URL
    
    var entersReaderIfAvailable = false
    
    var onFinish: (() -> Void)? = nil
    
    /// 初始化`WWSafariViewUI`
    /// - Parameters:
    ///   - url: 要開啟的網址
    ///   - entersReaderIfAvailable: 是否在支援時自動進入閱讀器模式 (此選項僅在 Safari Reader 模式可用時才會生效)
    ///   - onFinish: Safari 畫面關閉時要執行的回呼
    public init(url: URL, entersReaderIfAvailable: Bool = false, onFinish: (() -> Void)? = nil) {
        self.url = url
        self.entersReaderIfAvailable = entersReaderIfAvailable
        self.onFinish = onFinish
    }
}

// MARK: - UIViewControllerRepresentable
extension WWSafariViewUI: UIViewControllerRepresentable {
    
    /// 建立用來接收 Safari delegate 事件的協調器
    ///
    /// - Returns: 負責轉接 UIKit delegate 事件的協調器物件
    public func makeCoordinator() -> Coordinator {
        Coordinator(onFinish: onFinish)
    }
    
    /// 建立 `SFSafariViewController`
    ///
    /// - Parameter context: SwiftUI 提供的上下文資訊
    /// - Returns: 用來顯示指定網址內容的 Safari 視圖控制器
    public func makeUIViewController(context: Context) -> SFSafariViewController {
        
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = entersReaderIfAvailable
        
        let controller = SFSafariViewController(url: url, configuration: configuration)
        controller.dismissButtonStyle = .close
        controller.delegate = context.coordinator
        
        return controller
    }
    
    /// 更新既有的 `SFSafariViewController` 狀態
    ///
    /// `SFSafariViewController` 建立後通常不需要額外更新，因此此實作保留為空
    ///
    /// - Parameters:
    ///   - uiViewController: 目前顯示中的 Safari 視圖控制器
    ///   - context: SwiftUI 提供的上下文資訊
    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
