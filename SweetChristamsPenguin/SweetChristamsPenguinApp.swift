//
//  SweetChristamsPenguinApp.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//

import SwiftUI

@main
struct SweetChristamsPenguinApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoadingView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
