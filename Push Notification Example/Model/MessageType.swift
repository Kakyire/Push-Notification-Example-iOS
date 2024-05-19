//
//  MessageType.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import Foundation

enum MessageType:String,Codable{
    case audio = "AUDIO"
    case message = "TEXT"
    case image = "IMAGE"
}
