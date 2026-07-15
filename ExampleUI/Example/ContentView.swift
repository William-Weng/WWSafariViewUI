//
//  ContentView.swift
//  Example
//
//  Created by William.Weng on 2026/6/25.
//

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
                .onLoadComplete({ controller, didLoadSuccessfully in
                    print(didLoadSuccessfully)
                })
                .onFinish { controller in
                    print(controller)
                }
        }
    }
}

#Preview {
    ContentView()
}
