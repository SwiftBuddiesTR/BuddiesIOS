//
//  MessagingListView.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import SwiftUI
import Localization

public struct MessagingListView: View {
    @EnvironmentObject private var coordinator: MessagingCoordinator
    @ObservedObject private var viewModel: MessagingListViewModel
    
    public init(viewModel: MessagingListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Group {
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
                        viewModel.fetchConversations()
                    }
                    .buttonStyle(.bordered)
                    
                }
            } else {
                conversationsList
            }
        }
        .navigationTitle(L.messaging_title)
        .searchable(text: $viewModel.searchText, prompt: L.$messaging_search_placeholder.localized)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    coordinator.push(.newMessage)
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .onAppear {
            viewModel.fetchConversations()
        }
    }
    
    private var conversationsList: some View {
        List {
            ForEach(viewModel.filteredConversations) { conversation in
                Button {
                    coordinator.push(.chatDetail(conversation))
                } label: {
                    ConversationRow(conversation: conversation)
                }
                .buttonStyle(.plain)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .overlay {
            if viewModel.conversations.isEmpty {
                ContentUnavailableView {
                    Label(L.$messaging_no_messages.localized, systemImage: "message")
                } description: {
                    Text("Tap the compose button to start a new conversation")
                }
            }
        }
    }
}

struct ConversationRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile image placeholder
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Text(String(conversation.name.first ?? "?"))
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.name)
                        .font(.headline)
                        .fontWeight(conversation.unread ? .semibold : .regular)
                    
                    Spacer()
                    
                    Text(conversation.time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text(conversation.lastMessage)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if conversation.unread {
                        Circle()
                            .fill(.blue)
                            .frame(width: 10, height: 10)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
} 
