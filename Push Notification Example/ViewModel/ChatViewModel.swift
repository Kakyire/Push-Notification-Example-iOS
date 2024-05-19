//
//  ChatManager.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import Foundation
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    
    @Published var users:[User] = []
    @Published var chats:[Chat] = []
    @Published var rooms:[ChatRoom] = []
    @Published var unreadMessages: [String : Int] = [:]
    @Published var errorMessage: String? = nil
    
    private let firestore = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    
    
    private let currentUserId = UserDefaults.standard.string(forKey: DefaultKeys.userId)
    
    
    
    func getUsers() {
        listener?.remove()
        listener = firestore.collection(CollectionName.users)
            .whereField("id", isNotEqualTo: currentUserId ?? "")
            .addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching users: \(error)")
                    if let error = error{
                        self.errorMessage = error.localizedDescription
                    }
                    
                    return
                }
                
                self.users = documents.compactMap{
                    doc -> User? in
                    try? doc.data(as: User.self)
                }
                
                
                print("result of request: \(self.users)")
                
                
                
            }
        
    }
    
    func getChatRooms(){
        listener?.remove()
        listener =  firestore.collection(CollectionName.chatroom)
            .whereField("userIds", arrayContains: currentUserId!)
            .order(by: "timestamp",descending: true)
            .addSnapshotListener{querySnapshot,error in
                
                guard let documents = querySnapshot?.documents else{
                    print("Error fetching chatRooms: \(error)")
                    if let error = error{
                        self.errorMessage = error.localizedDescription
                    }
                    return
                }
                
                self.rooms = documents.compactMap{ doc -> ChatRoom? in
                    try? doc.data(as: ChatRoom.self)}
                
                print("Rooms \(self.rooms)")
                
                
                
            }
        
    }
    
    func getChatMessages(withRoomId roomId:String){
        
        
        listener?.remove()
        
        listener =  firestore.collection(CollectionName.chatroom)
            .document(roomId)
            .collection(CollectionName.chats)
            .order(by: "timestamp",descending: true)
            .addSnapshotListener{ querySnapshot,error in
                
                guard let documents = querySnapshot?.documents else{
                    print("Error fetching messages: \(error)")
                    if let error = error{
                        self.errorMessage = error.localizedDescription
                    }
                    return
                }
                
                self.chats = documents.compactMap{ doc -> Chat? in
                    try? doc.data(as: Chat.self)}
            }
        
    }
    
    
    
    
    func send(message chat:Chat,withChatRoom room:ChatRoom,toPath chatRoomId:String) {
        let chatRoomRef = firestore.collection(CollectionName.chatroom).document(chatRoomId)
        let chatRef = chatRoomRef.collection(CollectionName.chats).document()
        
        firestore.runTransaction({(transaction,errorPointer) -> Any? in
            do{
                
                //creating chat room with its details
                try transaction.setData(from: room, forDocument: chatRoomRef,merge: true)
                //send message
                try transaction.setData(from:chat, forDocument: chatRef)
                //                try firestore.collection(CollectionName.chatroom)
                //                    .document(chatRoomId)
                //                    .collection(CollectionName.chats)
                //                    .addDocument(from: chat)
                
                
            }catch let error {
                errorPointer?.pointee = error as NSError
                print("Error sending message: \(error)")
                self.errorMessage = error.localizedDescription
                
                return nil
            }
            return nil
        }) {(object, error) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            } else {
                print("Transaction successfully committed!")
            }
        }
        
        
    }
    
    func getUnreadMessages(within roomId:String){
        listener?.remove()
        
        listener = firestore.collection(CollectionName.chatroom)
            .document(roomId)
            .collection(CollectionName.chats)
            .whereField("messageRead", isEqualTo: false)
            .whereField("senderId", isNotEqualTo:  currentUserId ?? "")
            .addSnapshotListener{querySnapshot,error in
                guard let documents = querySnapshot?.documents else{
                    print("Error getting unread messages: \(error)")
                    if let error = error{
//                        self.errorMessage = error.localizedDescription
                    }
                    return
                }
                
                self.unreadMessages[roomId] = documents.count
                print("UnreadMessages: \(self.unreadMessages)")
            }
    }
    
    func updateUnreadMessage(at roomId:String,with chat:Chat){
        //        do{
        firestore.collection(CollectionName.chatroom)
            .document(roomId)
            .collection(CollectionName.chats)
            .document(chat.id!)
            .updateData(["messageRead":true])
        //        }catch{
        //            print("Error updating readMessage: \(error.localizedDescription)")
        //        }
    }
    
    deinit{
        listener?.remove()
    }
    
}
