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
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .frame(maxWidth: .infinity)
    }
}
