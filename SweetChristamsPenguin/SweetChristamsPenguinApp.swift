//
//  SweetChristamsPenguinApp.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//

import SwiftUI
import AppsFlyerLib
import OneSignalFramework

@main
struct SweetChristamsPenguinApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        AppsFlyerLib.shared().appsFlyerDevKey = "9gBZbuLrYAtzPaC7zHGqGj"
        AppsFlyerLib.shared().appleAppID = "6738710207"
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().isDebug = true
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoadingView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
