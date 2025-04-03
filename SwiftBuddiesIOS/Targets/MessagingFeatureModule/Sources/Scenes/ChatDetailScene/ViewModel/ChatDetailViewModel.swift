//
//  ChatDetailViewModel.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import Foundation
import Combine

@MainActor
public class ChatDetailViewModel: ObservableObject {
    public let conversation: Conversation
    
    @Published public var messages: [Message] = []
    @Published public var messageText: String = ""
    @Published public var isLoading: Bool = false
    @Published public var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(conversation: Conversation) {
        self.conversation = conversation
        
        // In a real app, you'd fetch messages for this conversation
        fetchMessages()
    }
    
    public func fetchMessages() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            // Empty state is shown initially in this demo
            self?.isLoading = false
        }
    }
    
    public func sendMessage(_ content: String) {
        guard !content.isEmpty else { return }
        
        let newMessage = Message(
            id: UUID().uuidString,
            content: content,
            isFromCurrentUser: true,
            timestamp: Date()
        )
        
        messages.append(newMessage)
        
        // Simulate a reply after a short delay
        if messages.count == 1 {
            simulateReply()
        }
    }
    
    private func simulateReply() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            let replyMessage = Message(
                id: UUID().uuidString,
                content: "Thanks for your message! How can I help you today?",
                isFromCurrentUser: false,
                timestamp: Date()
            )
            
            self.messages.append(replyMessage)
        }
    }
} 