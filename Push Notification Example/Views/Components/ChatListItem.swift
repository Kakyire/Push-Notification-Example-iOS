//
//  ChatListItem.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 11/05/2024.
//

import SwiftUI

struct ChatListItem: View {
    
    @AppStorage(DefaultKeys.userId) var currentUserId = ""
    
    let chatRoom: ChatRoom
    @ObservedObject var chatViewModel : ChatViewModel
    
    
    var body: some View {
        HStack{
            if let participant = chatRoom.participants.first(where: {$0.id != currentUserId}){
                
                ProfileImage(imageUrl: participant.image)
                
                HStack {
                    VStack(alignment:.leading){
                        Text(participant.name)
                        Text(chatRoom.lastMessage)
                            .font(.system(size: 14))
                            .foregroundStyle(.separator)
                            .lineLimit(1)
                        
                        
                        
                    }
                    Spacer()
                    
                    VStack (){
                        
                        if let timestamp = chatRoom.timestamp{
                            let time = DateAndTimeUtils.formattedDateString(from: timestamp,includeMinAgo: false)
                            
                            Text(time)
                                .font(.system(size: 14))
                                .foregroundStyle(.separator)
                        }
                        
                        
                        
                        if let unreadMessages = chatViewModel.unreadMessages[chatRoom.id], unreadMessages > 0 {

                            Text("\(unreadMessages)")
                                .font(.system(size: 14))
                                .foregroundColor(.primary)
                                .colorInvert()
                                .padding(.horizontal,8)
                                .padding(.vertical,4)
                                .background(.red)
                                .clipShape(Capsule())
                            
                            //                                .padding(.horizontal)
                        }
                        
                    }
                }
            }
            Spacer()
            
            
            
        }
        .onAppear{
            chatViewModel.getUnreadMessages(within: chatRoom.id)
        }
    }
}

#Preview {
    ChatListItem(chatRoom: ChatRoom(id: "8x9r3zCiOIUTuB8ud6m2WG6L1zo1qtu63YONEFUTDGdDpaZrCzQfNhC3", participants: [Participant(id: "8x9r3zCiOIUTuB8ud6m2WG6L1zo1", name: "Jane Doe", image: nil), Participant(id: "qtu63YONEFUTDGdDpaZrCzQfNhC3", name: "Kakyire", image: nil)], userIds: ["qtu63YONEFUTDGdDpaZrCzQfNhC3", "8x9r3zCiOIUTuB8ud6m2WG6L1zo1"], lastMessageType: "TEXT", lastMessage: "This is offline message", timestamp: Date())
                 ,chatViewModel: ChatViewModel())
}

