//
//  StringExt.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import Foundation

extension String{
    func isValidEmail() -> Bool {
        // Regular expression pattern for validating email address
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        
        // Create NSPredicate with regex pattern
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        // Evaluate the email address against the regex pattern
        return emailPredicate.evaluate(with: self)
    }
}
