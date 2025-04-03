//
//  MessagingView.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import SwiftUI
import Localization

public struct MessagingView: View {
    private let module: MessagingModule
    
    public init() {
        self.module = MessagingModule()
    }
    
    public var body: some View {
        MessagingFlow(module: module)
    }
}

#Preview {
    MessagingView()
}
