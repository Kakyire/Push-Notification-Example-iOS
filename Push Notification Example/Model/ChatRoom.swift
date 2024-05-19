//
//  ChatRoom.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import Foundation
import FirebaseFirestore

struct ChatRoom: Codable,Identifiable, Hashable{

    
   
    let id: String
    let participants: [Participant]
    let userIds: [String]
    let lastMessageType: String
    let lastMessage: String
    @ServerTimestamp var timestamp: Date?
    
    enum CodingKeys:String, CodingKey {
        case id
        case userIds 
        case participants
        case lastMessageType
        case lastMessage
        case timestamp
       
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
