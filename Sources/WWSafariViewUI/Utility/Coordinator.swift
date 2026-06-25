//
//  Coordinator.swift
//  WWSafariViewUI
//
//  Created by William.Weng on 2026/6/25.
//

import SwiftUI
import SafariServices

// MARK: - Coordinator
public extension WWSafariViewUI {
    
    /// 負責接收 `SFSafariViewControllerDelegate` 事件的協調器
    final class Coordinator: NSObject {
        
        private let onFinish: (() -> Void)?     // Safari 畫面關閉時要執行的回呼
        
        /// 建立協調器
        ///
        /// - Parameter onFinish: Safari 畫面關閉時執行的回呼
        init(onFinish: (() -> Void)?) {
            self.onFinish = onFinish
        }
    }
}

// MARK: - SFSafariViewControllerDelegate
extension WWSafariViewUI.Coordinator: SFSafariViewControllerDelegate {
    
    /// 使用者關閉 Safari 畫面時呼叫
    ///
    /// - Parameter controller: 目前被關閉的 Safari 視圖控制器
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        onFinish?()
    }
}
