//
//  MenuView.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            Image("menuBg")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image("logo")
                    .scaledToFit()
                
                NavigationLink {
                    GameMainPenguinView()
                } label: {
                    Image("ply")
                        .scaledToFit()
                }

                   
                

                HStack(spacing: 50) {
                    NavigationLink {
                        InfoTextView()
                    } label: {
                        Image("ingoe")
                            .scaledToFit()
                    }

                        
                    
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image("sets")
                            .scaledToFit()
                    }

                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
