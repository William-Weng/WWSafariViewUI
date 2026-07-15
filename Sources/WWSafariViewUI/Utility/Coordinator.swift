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
        
        var onLoadComplete: ((SFSafariViewController, Bool) -> Void)? = nil     // Safari 載入完成時的回呼變數
        var onFinish: ((SFSafariViewController) -> Void)? = nil                 // Safari 畫面關閉時要執行的回呼
    }
}

// MARK: - SFSafariViewControllerDelegate
extension WWSafariViewUI.Coordinator: SFSafariViewControllerDelegate {}
public extension WWSafariViewUI.Coordinator {
    
    /// 初始載入完成事件
    /// - Parameters:
    ///   - controller: 目前載入的 Safari 視圖控制器
    ///   - didLoadSuccessfully: 這次載入是成功還是因為網路等問題失敗
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        onLoadComplete?(controller, didLoadSuccessfully)
    }
    
    /// 使用者關閉 Safari 畫面時呼叫
    ///
    /// - Parameter controller: 目前被關閉的 Safari 視圖控制器
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        onFinish?(controller)
    }
}
