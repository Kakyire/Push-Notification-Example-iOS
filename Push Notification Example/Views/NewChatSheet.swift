//
//  NewChatSheet.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 11/05/2024.
//

import SwiftUI

struct NewChatSheet: View  {
    @Environment(\.dismiss) var dismiss
    let onTap: (_ user:User) -> Void
    
    @StateObject var chatViewModel = ChatViewModel()
    
    @AppStorage(DefaultKeys.userId) var currentUserId = ""
    
    @State var users:[User] = []
    

    var body: some View {
        NavigationView {
            VStack{
                if chatViewModel.users.isEmpty {
                    Text("There are no new chats at this time")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }else{
                    List(chatViewModel.users){user in
                            NewChatItem(user: user){
                                onTap(user)
                                dismiss()
                        }.listRowSeparator(.hidden)
                        
                        
                    }
                }
            }.onAppear{
                chatViewModel.getUsers()

            }
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action:{dismiss()}){Image(systemName: "xmark.circle")})
        }.preferredColorScheme(.light)
    }
}

#Preview {
    NewChatSheet(){_ in}
}
