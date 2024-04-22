//
//  LoginButtonViewModifier.swift
//  Design
//
//  Created by Berkay Tuncel on 19.04.2024.
//

import SwiftUI

struct LoginButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(DesignAsset.loginStrokeColor.swiftUIColor)
    }
}

struct LoginTextFieldModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .fontWeight(.bold)
            .frame(height: 55)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(backgroundColor, lineWidth: 2)
            )
    }
}
