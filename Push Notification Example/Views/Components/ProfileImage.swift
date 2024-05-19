//
//  ProfileImage.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 14/05/2024.
//

import SwiftUI

struct ProfileImage: View {
    let imageUrl: String?
    
    var body: some View {
        if imageUrl == nil {
            Image("user_avater")
                .resizable()
                .frame(width: 50,height: 50)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .scaledToFit()
        }else{
            AsyncImage(url: URL(string: imageUrl!),content:  {image in
                image.resizable()
                    .scaledToFit()
            },placeholder:{
                Image("user_avatar")
            })
            .frame(width: 50,height: 50)
            .clipShape(Circle())
        }
    }
}

#Preview {
    ProfileImage(imageUrl: nil)
}
