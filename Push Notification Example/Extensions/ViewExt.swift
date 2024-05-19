//
//  ViewExt.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 10/05/2024.
//

import SwiftUI


extension View{
    func cornerRadius(_ radius:CGFloat,corners:UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius,corners: corners))
    }
    
    func toast(isPresented: Binding<Bool>, message: String,onDismiss: (() -> Void)? = nil) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message,onDismiss: onDismiss))
    }
}
