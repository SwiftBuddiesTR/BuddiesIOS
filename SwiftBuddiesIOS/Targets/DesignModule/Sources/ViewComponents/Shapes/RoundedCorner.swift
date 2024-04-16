//
//  RoundedCorner.swift
//  Design
//
//  Created by Halit Baskurt on 16.04.2024.
//

import SwiftUI

public struct RoundedCorner: Shape {
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = [.allCorners]
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
