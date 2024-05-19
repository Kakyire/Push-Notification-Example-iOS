//
//  RoundedCorner.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 10/05/2024.
//

import SwiftUI

struct RoundedCorner:Shape{
    
    var radius:CGFloat 
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
    
}
