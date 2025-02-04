//
//  SwiftUIViewWebView.swift
//  Monobanka
//
//  Created by Andrii Momot on 01.02.2024.
//

import SwiftUI
import WebKit

struct SwiftUIViewWebView: View {
    var url: URL?
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            WebView(url: url)
        }
    }
}

struct WebView: UIViewRepresentable {
    var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
