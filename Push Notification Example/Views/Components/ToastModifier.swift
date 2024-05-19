//
//  ToastModifier.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 18/05/2024.
//

import SwiftUI

struct ToastModifier: ViewModifier{
  
    @Binding var isPresented: Bool
    let message: String
    var onDismiss: (() -> Void)? = nil
    func body(content: Content) -> some View {
        ZStack{
            content
            if isPresented{
                VStack{
                    Spacer()
                    Text(message)
                        .foregroundStyle(.primary)
                        .colorInvert()
                        .padding()
                        .background(.primary.opacity(0.6))
                        .cornerRadius(10)
                        .shadow(radius: 12)
                        .padding(.bottom,20)
                        
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation{
                            self.isPresented = false
                            onDismiss?()
                        }
                    }
                }
    
            }
        }
    }
    
    
    
}
