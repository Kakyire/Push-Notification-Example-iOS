//
//  Participant.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import Foundation

struct Participant:Codable,Identifiable,Hashable {
    let id:String
    let name: String
    let image: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
