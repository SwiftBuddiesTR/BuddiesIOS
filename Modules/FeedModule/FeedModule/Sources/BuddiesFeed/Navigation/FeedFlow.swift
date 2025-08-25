//
//  File.swift
//  SwiftBuddiesIOS
//
//  Created by dogukaan on 19.12.2024.
//

import SwiftUI

@MainActor
final class BuddiesFeedCoordinator: ObservableObject {
    enum BuddiesFeedRoute: Hashable, Identifiable {
        var id: Int {
            switch self {
            default:
                self.hashValue
            }
        }

        case addPost
        case postDetail(String)
        case userProfile(String)
    }
    
    @Published var navigationStack: [BuddiesFeedRoute] = []
    @Published var presented: BuddiesFeedRoute?
    
    func push(_ route: BuddiesFeedRoute) {
        navigationStack.append(route)
    }
    
    func popToRoot() {
        navigationStack.removeAll()
    }
    
    func pop() {
        navigationStack.removeLast()
    }
    
    func present(_ route: BuddiesFeedRoute) {
        presented = route
    }
    
    func dismissSheet() {
        presented = nil
    }
}

public struct FeedFlow: View {
    @StateObject private var coordinator: BuddiesFeedCoordinator
    private let module: BuddiesFeedModule
    
    init(module: BuddiesFeedModule) {
        self._coordinator = StateObject(wrappedValue: BuddiesFeedCoordinator())
        self.module = module
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navigationStack) {
            module.getFeedView()
                .environmentObject(coordinator)
                .navigationDestination(for: BuddiesFeedCoordinator.BuddiesFeedRoute.self) { route in
                    routeTo(route)
                }
                .sheet(item: $coordinator.presented) { route in
                    routeTo(route)
                }
                .fullScreenCover(item: $coordinator.presented) { item in
                    routeTo(item)
                }
        }
    }
    
    @ViewBuilder
    func routeTo(_ route: BuddiesFeedCoordinator.BuddiesFeedRoute) -> some View {
        switch route {
        case .addPost:
            AddPostView()
                .environmentObject(coordinator)
        case .postDetail(let postId):
            Text("Post Detail View: \(postId)")
        case .userProfile(let userId):
            Text("User Profile: \(userId)")
        }
    }
}

#Preview {
    FeedFlow(module: .init())
}
