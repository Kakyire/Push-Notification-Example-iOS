//
//  ChatItemView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 10/05/2024.
//

import SwiftUI

struct ChatItemView: View {
    
    @AppStorage(DefaultKeys.userId) var currentUserId = ""
    let chats:[Chat]
    
    var body: some View {
        VStack{
            let groupedChats = ChatUtils.groupChatByTimestamp(chats: chats)
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment:.center,pinnedViews: [.sectionHeaders]) {
                        
                        ForEach (groupedChats,id: \.self){grouped in
                            let date = DateAndTimeUtils.formattedDateString(from: grouped.date)
                            
                            Section(header:
                                        HStack {
                                Spacer()
                                Text(date)
                                    .padding()
                                    .background(.offWhite)
                                    .cornerRadius(10)
                                Spacer()
                            }){
                                ForEach(grouped.chats) { chat in
                                    
                                    VStack{
                                        if currentUserId == chat.senderId {
                                            OutgoingItemView(chat: chat)
                                            
                                        }else{
                                            IncomingItemView(chat: chat)
                                            
                                        }
                                        
                                    }
                                    .id(chat.id)
                                    
                                } 

                            }
                            
                            
                        }
                        .onAppear{
                           scrollToBottom(proxy: proxy, groupChats: groupedChats)
                        }
                        .onChange(of: chats){
                            scrollToBottom(proxy: proxy,groupChats: groupedChats)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listItemTint(.clear)
                    }
                   
                    .listStyle(.plain)
                   
                }
                
                .scrollIndicators(.never)
                
            }
            
            
            Spacer()
            
            
        }.padding(.top)
            .background(.chatBackground)
        
        
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy, groupChats: [GroupedChat]) {
        if let lastGroupedChat = groupChats.last, let lastChat = lastGroupedChat.chats.last {
            DispatchQueue.main.async {
                withAnimation {
                    proxy.scrollTo(lastChat.id, anchor: .bottom)
                }
            }
        }
    }
}

#Preview {
    
    ChatItemView(chats:[Chat(senderId: "", receiverId: "", messageType: MessageType.message.rawValue,message: "Hello there",timestamp: Date()),
                        Chat(senderId: "23", receiverId: "", messageType: MessageType.message.rawValue,message: "Hello there",timestamp: Date())])
}


