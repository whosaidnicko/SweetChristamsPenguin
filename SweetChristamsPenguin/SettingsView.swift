//
//  SettingsView.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {
        ZStack {
            Image("menuBg")
                .resizable()
                .ignoresSafeArea()
            
          Image("settingsLbe")
                .overlay {
                    
                    VStack {
//                        Button {
//                            if let url = URL(string: "mailto:barneydwuystrjb325@gmail.com") {
//                                if UIApplication.shared.canOpenURL(url) {
//                                    UIApplication.shared.open(url)
//                                }
//                            }
//                        } label: {
//                            Image("btnSet")
//                               .overlay {
//                                   Text("Contact Us")
//                                       .font(.custom(jeju, size: 25))
//                                       .foregroundStyle(.black)
//                               }
//                        }

                       
                        Button {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                     SKStoreReviewController.requestReview(in: windowScene)
                                 }
                        } label: {
                            Image("btnSet")
                               .overlay {
                                   Text("Rate")
                                       .font(.custom(jeju, size: 25))
                                       .foregroundStyle(.black)
                               }
                        }
                    }
                }
                .offset(x: 70)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: IceBackButton())
    }
}
