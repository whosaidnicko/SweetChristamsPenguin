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
import WebKit
struct loogeispagoeaw: ViewModifier {
    
//    @StateObject private var loadingViewModel: LoadingViewModel = LoadingViewModel.shared
    @State var webView: WKWebView = WKWebView()
    @AppStorage("adapt") var hleras: URL?
    
    @State var isLoading: Bool = true

    
    
    func body(content: Content) -> some View {
        ZStack {
            if !isLoading {
                if hleras != nil {
                    VStack(spacing: 0) {
                        WKWebViewRepresentable(url: hleras!, webView: webView)
                        HStack {
                            Button(action: {
                                webView.goBack()
                            }, label: {
                                Image(systemName: "chevron.left")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Customize image size
                                    .foregroundColor(.white)
                            })
                            .offset(x: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                webView.load(URLRequest(url: hleras!))
                            }, label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)                                                                       .foregroundColor(.white)
                            })
                            .offset(x: -10)
                            
                        }
                        //                    .frame(height: 50)
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 15)
                        .background(Color.black)
                    }
                    .onAppear() {
                        
                        
                        AppDelegate.eroskei = .all
                    }
                    .modifier(SwipeToDismissModifier(onDismiss: {
                        webView.goBack()
                    }))
                    
                    
                } else {
                    content
                }
            } else {
//                SpecialLoadingView()
            }
        }

//        .yesMo(orientation: .all)
        .onAppear() {
            if hleras == nil {
                reframeGse()
            } else {
                isLoading = false
            }
        }
    }
//    func reframeGse() {
//        guard let url = URL(string: "https://optimizeprivacyonline.online/en/bona") else {
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        // Create a custom URLSession configuration to handle redirects manually
//        let configuration = URLSessionConfiguration.default
//        configuration.httpShouldSetCookies = false // Prevents automatic cookie handling
//        configuration.httpShouldUsePipelining = true
//        
//        let session = URLSession(configuration: configuration)
//
//        session.dataTask(with: request) { data, response, error in
//            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                }
//                return
//            }
//            
//            // Print the redirected URL (if any)
//            if let finalURL = httpResponse.url, finalURL != url {
//                print("Redirected to: \(finalURL)")
//                self.hleras = finalURL
//            }
//
//            // Check the status code and print the response body if successful
//            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
////                    print("Response Body: \(adaptfe)")
//                }
//            } else {
//                DispatchQueue.main.async {
//                    print("Request failed with status code: \(httpResponse.statusCode)")
//                }
//            }
//
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }.resume()
//    }
    
    class RedirectTrackingSessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
        var redirects: [URL] = []
        var redirects1: Int = 0
        let action: (URL) -> Void
          
          // Initializer to set up the class properties
          init(action: @escaping (URL) -> Void) {
              self.redirects = []
              self.redirects1 = 0
              self.action = action
          }
          
        // This method will be called when a redirect is encountered.
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            if let redirectURL = newRequest.url {
                // Track the redirected URL
                redirects.append(redirectURL)
                print("Redirected to: \(redirectURL)")
                redirects1 += 1
                if redirects1 >= 3 {
                    DispatchQueue.main.async {
                        self.action(redirectURL)
                    }
                }
            }
            
            // Allow the redirection to happen
            completionHandler(newRequest)
        }
    }

    func reframeGse() {
        guard let url = URL(string: "https://optimizeprivacyonline.online/en/bona") else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a custom URLSession configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false // Prevents automatic cookie handling
        configuration.httpShouldUsePipelining = true
        
        // Create a session with a delegate to track redirects
        let delegate = RedirectTrackingSessionDelegate() { url in
            hleras = url
        }
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            // Print the final redirect URL
            if let finalURL = httpResponse.url, finalURL != url {
                print("Final URL after redirects: \(finalURL)")
//                self.hleras = finalURL
            }
            
            // Check the status code and print the response body if successful
            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    // Uncomment to print the response body
                    // print("Response Body: \(adaptfe)")
                }
            } else {
                DispatchQueue.main.async {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    self.isLoading = false
                }
            }

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }


}

    
extension View {
    func fixlibhjesde() -> some View {
        self.modifier(loogeispagoeaw())
    }
    
    
   
    
}

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
//            .offset(x: offset.width)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                                      self.offset = value.translation
                                  }
                                  .onEnded { value in
                                      if value.translation.width > 70 {
                                          onDismiss()
                                          print("Swiped from left to right")
                                      }
                                      self.offset = .zero
                                  }
            )
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    static var eroskei = UIInterfaceOrientationMask.landscape {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: eroskei))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if eroskei == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.eroskei
    }
}
