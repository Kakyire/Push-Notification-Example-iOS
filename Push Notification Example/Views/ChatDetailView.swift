//
//  ChatDetailView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 10/05/2024.
//

import SwiftUI

struct ChatDetailView: View {
    
    
    let otherUserId: String
    
    @ObservedObject var userViewModel : UserViewModel// = UserViewModel()
    @ObservedObject var chatViewModel : ChatViewModel //= ChatViewModel()
    
    @AppStorage(DefaultKeys.userId) var currentUserId = ""
    @State private var message = ""
    @FocusState var isInputActive : Bool
    
    @State var chatRoomId = ""
    
    
    
    var body: some View {
        VStack{
            
            //user info
            HStack{
                BackButton()
                if let otherUser = userViewModel.otherUser{
                    
                    ZStack (alignment:.bottomTrailing){
                        ProfileImage(imageUrl: otherUser.image)
                        
                      if  otherUser.isOnline{
                          Circle()
                              .foregroundColor(.green)
                              .frame(width: 10,height: 10)
                        }
                        
                    }
                    
                    VStack(alignment:.leading){
                        Text(otherUser.name)
                        
                        let onlineStatus = otherUser.isOnline ? "online" : "offline"
                        Text(onlineStatus)
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                        
                    }
                }
                Spacer()
                
            }
            
            //chat items
            ChatItemView(chats:chatViewModel.chats)
            Divider()
            Spacer()
            
            //Bottom buttons
            HStack{
                Image("attach")
                ZStack(alignment:.trailing) {
                    TextField("Write your message", text: $message,axis: .vertical)
                        .focused($isInputActive)
                        .lineLimit(5)
                        .autocapitalization(.sentences)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(.offWhite)
                    .cornerRadius(10, corners: [.allCorners])
                    

                    Button (action:{ 
                        
                       
                      
                        
                        sendMessage()
                        print("messageSent: \(message)")
                       
                        
                       
                }){
                    Image(systemName: "paperplane")
                                .padding(4)
                        }.disabled(message.isEmpty)
                    
                }
                    
                Image("camera")
                Image( "mic")

            }
//            Divider()
        }.onAppear{
            chatRoomId = ChatUtils.generateChatRoom(withCurrentUserId: currentUserId, and: otherUserId)
            userViewModel.getUser()
            userViewModel.getOtherUser(withId: otherUserId)
            
            chatViewModel.getChatMessages(withRoomId: chatRoomId)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            isInputActive = false
        }
        .safeAreaPadding(.horizontal)
    }
    
    
    fileprivate func sendMessage() {
        if let currentUser = userViewModel.userDetails, let otherUser = userViewModel.otherUser{
            
            let users = [otherUser,currentUser]
            let ids = [currentUserId,otherUserId]
            
            let participants = users.toParticipants()
            
            let chatRoom = ChatRoom(id:chatRoomId,participants: participants,userIds: ids,lastMessageType: MessageType.message.rawValue, lastMessage: message)
            
            
            let chat = Chat(senderId: currentUserId, receiverId: otherUserId, messageType: MessageType.message.rawValue, message: message)
            
            
            
            chatViewModel.send(message: chat, withChatRoom: chatRoom, toPath: chatRoomId)
            message = ""
            
        }
    }
}


#Preview {
    ChatDetailView(otherUserId: "",userViewModel: UserViewModel(),chatViewModel: ChatViewModel())
}
