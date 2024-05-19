//
//  ChatUtils.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 14/05/2024.
//

import Foundation

struct ChatUtils{
    
    static func generateChatRoom(withCurrentUserId currentUser: String, and otherUser:String) -> String{
        let participants = [currentUser,otherUser].sorted()
        return participants.joined()
    }
    
    static func groupChatByTimestamp (chats:[Chat]) -> [GroupedChat]{
        var groupedChat = [GroupedChat]()
        var grouping = [String:[Chat]]()
        
        let dictionary = Dictionary(grouping: chats, by: {DateAndTimeUtils.formatDate(from: $0.timestamp ?? Date())})
        
        for (key, chats) in dictionary{
            let sortedChat = chats.sorted{$0.timestamp ?? Date() < $1.timestamp ?? Date()}
            
            groupedChat.append(GroupedChat(date: key, chats: sortedChat))
            
            
        }
        
       
        
        return groupedChat.sorted { $0.date < $1.date }
    }
}
