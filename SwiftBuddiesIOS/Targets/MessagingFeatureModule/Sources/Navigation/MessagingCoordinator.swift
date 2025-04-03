//
//  MessagingCoordinator.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import SwiftUI

@MainActor
final class MessagingCoordinator: ObservableObject {
    enum MessagingRoute: Hashable {
        case chatDetail(Conversation)
        case newMessage
    }
    
    @Published var navigationStack: [MessagingRoute] = []
    
    func push(_ route: MessagingRoute) {
        navigationStack.append(route)
    }
    
    func popToRoot() {
        navigationStack.removeAll()
    }
} 