//
//  ChatListView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 11/05/2024.
//

import SwiftUI

struct ChatsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingSheet = false
    @State private var isAlertShowing = false
    @State private var isDetailLinkActive = false
    @State private var gotoSettings = false
    
    @State private var user:User? = nil
    @StateObject var userViewModel = UserViewModel()
    @StateObject var chatViewModel = ChatViewModel()

    
    @AppStorage(DefaultKeys.userId) var currentUserId = ""

    
    var body: some View {
        VStack{
            
            if user != nil {
                NavigationLink(destination: ChatDetailView(otherUserId: user!.id,userViewModel: userViewModel,chatViewModel: chatViewModel), isActive: $isDetailLinkActive) {
                    EmptyView()
                }
                .hidden()
            }
            
            NavigationLink(destination: SettingsView(), isActive: $gotoSettings) {
                EmptyView()
            }
            .hidden()
            
            
            if chatViewModel.rooms.isEmpty {
                Text("Click on the plus sign to add chat")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }else{
                List(chatViewModel.rooms,id: \.self){ room in
                    
                    if let participant = room.participants.first(where: {$0.id != currentUserId}){
                        
                        NavigationLink(destination:ChatDetailView(otherUserId: participant.id,userViewModel: userViewModel,chatViewModel: chatViewModel)){
                            ChatListItem(chatRoom: room,chatViewModel: chatViewModel)

                        }
                    }
                    
                    

                    
                    
                }.transition(.opacity)
            }
        }
        .onAppear{
            withAnimation{
                chatViewModel.getChatRooms()
//                userViewModel.setupPresence()
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    isShowingSheet.toggle()
                }){
                    Image(systemName: "plus.circle.fill")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    
                    gotoSettings.toggle()
                }){
                    Image(systemName: "gearshape")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
//        .navigationDestination(isPresented: $gotoSettings, destination: SettingsView())
        .sheet(isPresented: $isShowingSheet,
               
               content: {
            NewChatSheet(){user in
                self.user = user
                isDetailLinkActive = true
                
            }
        })
        
    }
}

#Preview {
    ChatsView()
}
