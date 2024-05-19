//
//  BackButton.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 11/05/2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        Image("back_arrow")
            .onTapGesture {
                mode.wrappedValue.dismiss()
            }
    }
}

#Preview {
    BackButton()
}
