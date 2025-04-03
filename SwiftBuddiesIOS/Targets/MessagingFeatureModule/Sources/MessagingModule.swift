//
//  MessagingModule.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import SwiftUI
import Foundation

@MainActor
public struct MessagingModule: @preconcurrency MessagingModuleProtocol {
    private var messagingView: MessagingListView!
    
    public init() {
        self.messagingView = makeMessagingView()
    }
    
    public func getMessagingView() -> MessagingListView {
        return messagingView
    }
    
    private func makeMessagingView() -> MessagingListView {
        let viewModel = makeViewModel()
        return MessagingListView(viewModel: viewModel)
    }
    
    private func makeViewModel() -> MessagingListViewModel {
        // In a real implementation, you'd inject network clients, repositories, etc.
        return MessagingListViewModel()
    }
} 