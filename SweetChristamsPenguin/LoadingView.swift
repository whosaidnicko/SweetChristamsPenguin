//
//  LoadingView.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//

import SwiftUI


struct LoadingView: View {
    @State var menu: Bool = false
    @State var animateLoading: Bool = false
    var body: some View {
        ZStack {
            Image("bgLoading")
                .resizable()
                .ignoresSafeArea()
            
            NavigationLink("", destination: MenuView(), isActive: $menu)
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                Spacer()
                
                VStack(spacing: 0) {
                    Image("penguin")
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    Image("loadingZamorojenko")
                        .overlay {
                            Rectangle()
                                .trim(from: 0, to: animateLoading ? 1 : 0)
                                .fill(LinearGradient(colors: [Color.init(hex: "#FFCC00"), Color.init(hex: "#31A31A")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 386.9, height: 10.7)
                        }
                        .onAppear() {
                            withAnimation(Animation.linear(duration: 4)) {
                                animateLoading = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                menu = true 
                            }
                        }
                }
            }
            .padding()
        }
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
