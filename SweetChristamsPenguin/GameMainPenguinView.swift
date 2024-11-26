//
//  GameMainPenguinView.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 27/11/2024.
//

import SwiftUI


struct GameMainPenguinView: View {
    @State var startAnimation: Bool = false
    @State var loadingFinished: Bool = false
    var body: some View {
        ZStack {
            Image("gameBg")
                .resizable()
                .ignoresSafeArea()
            VStack {
                WKWebViewRepresentable(url: URL(string: "https://plays.org/game/sweet-penguin/")!, onLoadCompletion: {
                    withAnimation {
                        loadingFinished = true
                    }
                })
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)

                .cornerRadius(30)
                .mask({
                    Rectangle()
                    
                        .frame( width: UIScreen.main.bounds.width > 680 ?  UIScreen.main.bounds.width * 0.58 : UIScreen.main.bounds.width * 0.72)
                        .cornerRadius(25)
                })
                .opacity(loadingFinished ? 1 : 0)
            }
            
            Image("penguin")
                .scaleEffect(startAnimation ? 1 : 0.78)
                .opacity(!loadingFinished ? 1 : 0)
                .onAppear() {
                    withAnimation(Animation.linear(duration: 2).repeatForever()) {
                        startAnimation = true
                    }
                }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: IceBackButton())
    }
}
import WebKit
struct WKWebViewRepresentable: UIViewRepresentable {

   typealias UIViewType = WKWebView
   var url: URL
   var webView: WKWebView
   var onLoadCompletion: (() -> Void)?

   init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil) {
       self.url = url
       
       self.webView = webView
       self.webView.layer.opacity = 0
       self.onLoadCompletion = onLoadCompletion
   }

   func makeUIView(context: Context) -> WKWebView {
       webView.uiDelegate = context.coordinator
       webView.navigationDelegate = context.coordinator
       return webView
   }

   func updateUIView(_ uiView: UIViewType, context: Context) {
       let request = URLRequest(url: url)
       uiView.load(request)
       uiView.scrollView.isScrollEnabled = true
       uiView.scrollView.bounces = true
   }

   func makeCoordinator() -> Coordinator {
       Coordinator(self)
   }
}

extension WKWebViewRepresentable {

   final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
       var parent: WKWebViewRepresentable
       private var webViews: [WKWebView]

       init(_ parent: WKWebViewRepresentable) {
           self.parent = parent
           
           self.webViews = []
       }

       func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
           if navigationAction.targetFrame == nil {
               let popupWebView = WKWebView(frame: .zero, configuration: configuration)
               popupWebView.navigationDelegate = self
               popupWebView.uiDelegate = self

               parent.webView.addSubview(popupWebView)
               popupWebView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                   popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                   popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                   popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
               ])

               self.webViews.append(popupWebView)
               return popupWebView
           }
           return nil
       }

       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           // Notify when page loading has finished
           parent.onLoadCompletion?()
           webView.layer.opacity = 1
       }

       func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           decisionHandler(.allow)
       }
   }

   func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
       return .all
   }
}
