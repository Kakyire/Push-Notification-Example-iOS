//
//  User.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import FirebaseFirestore
import Foundation

struct User: Codable,Hashable,Identifiable{
    var id: String = ""
    let name:String
    let email: String
    var image: String? = nil
    var password: String = ""
    var isOnline: Bool = false
    @ServerTimestamp var createdOn: Date?
    var updatedOn: Date?
    var lastActive: Date?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case email
        case image
        case createdOn, updatedOn, lastActive
        case isOnline = "nowAvailable"
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
