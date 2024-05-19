//
//  NewChatItem.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 11/05/2024.
//

import SwiftUI

struct NewChatItem: View {
    
    let user:User
    let onTap: () -> Void

    var body: some View {
        HStack{
            ProfileImage(imageUrl: user.image)
        
            Text(user.name)
                .font(.title)
                .padding(.horizontal)
            
//            Spacer()
//            NavigationLink(destination: ChatDetailView()){
//                Image(systemName: "plus.message")
////                    .renderingMode(.template)
//                    .foregroundColor(.secondary)
//            }
            Spacer()
            
            
            
            
          
        }.onTapGesture {
            onTap()
        }
    }
}

#Preview {
    NewChatItem(user: User(name: "Daniel", email: "mail")){
        
    }
}
