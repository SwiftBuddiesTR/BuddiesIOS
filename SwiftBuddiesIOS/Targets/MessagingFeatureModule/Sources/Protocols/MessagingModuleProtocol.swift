//
//  MessagingModuleProtocol.swift
//  MessagingFeature
//
//  Created by dogukaan on 2.04.2025.
//

import SwiftUI

public protocol MessagingModuleProtocol {
    associatedtype MessagingViewType: View
    
    func getMessagingView() -> MessagingViewType
} 