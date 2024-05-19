//
//  UserExt.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 14/05/2024.
//

import Foundation

extension [User]{
    
    func toParticipants() -> [Participant]{
        var participants:[Participant] = []
        
        for user in self {
            participants.append(Participant(id: user.id, name: user.name, image: user.image))
        }
        
        return participants
    }
}
