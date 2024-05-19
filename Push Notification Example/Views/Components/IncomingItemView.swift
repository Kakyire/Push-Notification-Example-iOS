//
//  IncomingItemView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 10/05/2024.
//

import SwiftUI

struct IncomingItemView: View {
    
    let chat:Chat
    
    @StateObject var chatViewModel = ChatViewModel()

    var body: some View {
        HStack (alignment:.top){
//            ProfileImage(imageUrl: nil)
           
            VStack (alignment:.leading){
//                Text("John Smith")
               
                VStack(alignment:.trailing) {
                    if let message = chat.message{
                        Text(message)
                            .padding()
                            .background(.incomingMessage)
                            .cornerRadius(15, corners: [.bottomLeft,.bottomRight,.topRight])
                    }
                   
                    let time = DateAndTimeUtils.formatTime(from: chat.timestamp)
                    Text(time)
                        .foregroundStyle(.time)
                        .padding(.trailing)
                }
                
               
            }
            Spacer(minLength: 30)
            
        }.onAppear{
            let roomId = ChatUtils.generateChatRoom(withCurrentUserId: chat.senderId, and: chat.receiverId)
            chatViewModel.updateUnreadMessage(at: roomId, with: chat)
        }
    }
}

#Preview {
    IncomingItemView(chat: Chat(senderId: "", receiverId: "", messageType: MessageType.message.rawValue,message: "Hello there",timestamp: Date()))
}
