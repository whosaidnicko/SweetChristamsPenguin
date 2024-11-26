//
//  SweetChristamsPenguinApp.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//

import SwiftUI

@main
struct SweetChristamsPenguinApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoadingView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
