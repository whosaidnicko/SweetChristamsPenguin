//
//  IceBackButton.swift
//  SweetChristamsPenguin
//
//  Created by Nicolae Chivriga on 26/11/2024.
//


import SwiftUI


struct IceBackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image("bkice")
                .resizable()
                .frame(width: 35, height: 35)
        }

    }
}
