//
//  OutgoingItemView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 10/05/2024.
//

import SwiftUI


struct OutgoingItemView: View {
    
    let chat:Chat
    
    var body: some View {
        HStack {
            Spacer(minLength: 30)
            VStack (alignment:.trailing){
                if let message = chat.message{
                    Text(message)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.deepBlue)
                        .cornerRadius(15, corners: [.bottomLeft,.topLeft,.bottomRight])
                }
                
                let time = DateAndTimeUtils.formatTime(from: chat.timestamp)
               
                Text(time)
                    .foregroundStyle(.time)
                    .padding(.trailing)
               
            }
            
        }//.padding()
    }
}

#Preview {
    OutgoingItemView(chat: Chat(senderId: "", receiverId: "", messageType: MessageType.message.rawValue,message: "Hello there",timestamp: Date()))
}
