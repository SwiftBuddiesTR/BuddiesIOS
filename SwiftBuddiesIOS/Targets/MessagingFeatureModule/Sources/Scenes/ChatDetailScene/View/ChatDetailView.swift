//
//  ChatDetailView.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import SwiftUI
import Localization

public struct ChatDetailView: View {
    @EnvironmentObject private var coordinator: MessagingCoordinator
    @StateObject private var viewModel: ChatDetailViewModel
    
    public init(conversation: Conversation) {
        self._viewModel = StateObject(wrappedValue: ChatDetailViewModel(conversation: conversation))
    }
    
    public var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                ContentUnavailableView {
                    Label {
                        L.messaging_error_loading
                    } icon: {
                        Image(systemName: "exclamationmark.triangle")
                    }
                } actions: {
                    Button(L.$button_retry.localized) {
                        viewModel.fetchMessages()
                    }
                    .buttonStyle(.bordered)

                }
            } else {
                messageContent
            }
        }
        .navigationTitle(viewModel.conversation.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var messageContent: some View {
        VStack {
            // Empty state or messages list
            if viewModel.messages.isEmpty {
                emptyStateView
            } else {
                messagesList
            }
            
            // Message input
            HStack {
                TextField(L.$messaging_message_placeholder.localized, text: $viewModel.messageText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "message")
                .font(.system(size: 60))
                .foregroundColor(Color(.systemGray4))
            Text("No messages yet")
                .font(.headline)
            Text("Start the conversation with \(viewModel.conversation.name)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
    }
    
    private var messagesList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.messages) { message in
                    MessageBubble(message: message)
                }
            }
            .padding()
        }
    }
    
    private func sendMessage() {
        viewModel.sendMessage(viewModel.messageText)
        viewModel.messageText = ""
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                Text(message.content)
                    .padding(12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .padding(.leading, 60)
            } else {
                Text(message.content)
                    .padding(12)
                    .background(Color(.systemGray5))
                    .foregroundColor(.primary)
                    .cornerRadius(16)
                    .padding(.trailing, 60)
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
} 
