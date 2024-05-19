//
//  UserProfileView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 14/05/2024.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject var userViewModel = UserViewModel()
    
    
    var body: some View {
        
        VStack{
            if let user = userViewModel.userDetails{
                ProfileImage(imageUrl: user.image)
                Text(user.name)
            }
            
            Spacer()
        }.onAppear{
            userViewModel.getUser()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
    }
}

#Preview {
    UserProfileView()
}
