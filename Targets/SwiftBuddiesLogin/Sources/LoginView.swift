//
//  LoginView.swift
//  Login
//
//  Created by Berkay Tuncel on 30.03.2024.
//  Copyright © 2024 SwiftBuddies. All rights reserved.
//

import SwiftUI
import FirebaseAuth

public struct LoginView: View {
    
    public init() {}
    
    public var body: some View {
        Text("Hello, World!")
            .onAppear(perform: {
                debugPrint(Auth.auth().currentUser != nil)
            })
    }
}

#Preview {
    LoginView()
}
