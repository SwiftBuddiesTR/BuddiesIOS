//
//  MessagingListViewModel.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import Foundation
import Combine

@MainActor
public class MessagingListViewModel: ObservableObject {
    @Published public var conversations: [Conversation] = []
    @Published public var searchText: String = ""
    @Published public var isLoading: Bool = false
    @Published public var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        // For the demo, we're loading sample data
        loadSampleData()
        
        // In a real app, you'd have something like:
        // setupSearchSubscription()
    }
    
    private func loadSampleData() {
        conversations = [
            Conversation(id: "1", name: "John Appleseed", lastMessage: "See you at the meetup!", time: "10:30 AM", unread: true),
            Conversation(id: "2", name: "Sarah Developer", lastMessage: "Thanks for sharing that article", time: "Yesterday", unread: false),
            Conversation(id: "3", name: "Swift Buddies Group", lastMessage: "Tim: Is everyone coming to the event?", time: "Wed", unread: true),
            Conversation(id: "4", name: "Alex Designer", lastMessage: "I'll send you the UI mockups soon", time: "Tue", unread: false),
            Conversation(id: "5", name: "Maya Coder", lastMessage: "Let's review that pull request", time: "Mon", unread: false)
        ]
    }
    
    // In a real implementation, this would fetch conversations from a service
    public func fetchConversations() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.loadSampleData()
            self?.isLoading = false
        }
    }
    
    public var filteredConversations: [Conversation] {
        guard !searchText.isEmpty else { return conversations }
        
        return conversations.filter { conversation in
            conversation.name.localizedCaseInsensitiveContains(searchText) ||
            conversation.lastMessage.localizedCaseInsensitiveContains(searchText)
        }
    }
} 