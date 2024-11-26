//
//  InfoTextView.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//

import SwiftUI

struct InfoTextView: View {
    var body: some View {
        ZStack {
            Image("menuBg")
                .resizable()
                .ignoresSafeArea()
            
            Image("infoTextRect")
                .overlay {
                    Text("""
Short story for 'Sweet Christmas of Penguin':
                         In a snowy kingdom, there lived a penguin named Pip, the biggest sweet tooth in the North. One Christmas, Pip discovered that Santa had accidentally dropped a sack of magical candies, scattering them across the icy lands. Determined to bring the sweets back, Pip set off on an adventure to collect them all and create the sweetest holiday celebration ever.
                         Along the way, Pip explores frosty caves, gingerbread villages, and meets playful elves with riddles to solve. But beware—snowstorms and clever owls are ready to cause trouble! Help Pip gather all the candies and make this Christmas the sweetest one yet!
""")
                    .font(.custom(jeju, size: 14))
                    .padding(.top, 50)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 140)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                }
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: IceBackButton())
    }
}
