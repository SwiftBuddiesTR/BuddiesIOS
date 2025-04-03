//
//  MessagingModels.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import Foundation

public struct Conversation: Identifiable, Hashable {
    public let id: String
    public let name: String
    public let lastMessage: String
    public let time: String
    public let unread: Bool
    
    public init(id: String, name: String, lastMessage: String, time: String, unread: Bool) {
        self.id = id
        self.name = name
        self.lastMessage = lastMessage
        self.time = time
        self.unread = unread
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }
}

public struct Message: Identifiable, Hashable {
    public let id: String
    public let content: String
    public let isFromCurrentUser: Bool
    public let timestamp: Date
    
    public init(id: String, content: String, isFromCurrentUser: Bool, timestamp: Date) {
        self.id = id
        self.content = content
        self.isFromCurrentUser = isFromCurrentUser
        self.timestamp = timestamp
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
} 