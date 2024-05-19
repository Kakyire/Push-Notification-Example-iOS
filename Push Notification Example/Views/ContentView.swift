//
//  ContentView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 09/05/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userMager = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if userMager.hasLoggedIn(){
                    ChatsView()
                }else{
                    WelcomeView()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
