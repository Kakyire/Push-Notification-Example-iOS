//
//  Chat.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import Foundation
import FirebaseFirestore

struct Chat: Codable,Identifiable,Hashable {
    @DocumentID var id: String?
    let senderId: String
    let receiverId: String
    let messageType: String
    var message: String? = nil
    var image: String? = nil
    var audio: String? = nil
    var isMessageRead: Bool = false
    @ServerTimestamp var timestamp: Date?
    
    enum CodingKeys: String, CodingKey{
        case id
        case receiverId, senderId
        case messageType
        case message, image, audio
        case isMessageRead = "messageRead"
        case timestamp
        
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}


