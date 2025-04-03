//
//  MessagingFlow.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import SwiftUI

public struct MessagingFlow: View {
    @StateObject private var coordinator: MessagingCoordinator
    private let module: MessagingModule
    
    public init(module: MessagingModule) {
        self._coordinator = StateObject(wrappedValue: MessagingCoordinator())
        self.module = module
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navigationStack) {
            module.getMessagingView()
                .environmentObject(coordinator)
                .navigationDestination(for: MessagingCoordinator.MessagingRoute.self) { route in
                    switch route {
                    case .chatDetail(let conversation):
                        ChatDetailView(conversation: conversation)
                            .environmentObject(coordinator)
                    case .newMessage:
                        // TODO: Implement new message screen
                        Text("New Message")
                            .environmentObject(coordinator)
                    }
                }
        }
    }
} 