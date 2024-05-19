//
//  SettingsView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 14/05/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var userViewModel = UserViewModel()
    @State private var isAlertShowing = false
    
    @State private var canLogout = false
    @AppStorage(DefaultKeys.userId) var currentUserId = ""


    
    var body: some View {
        VStack {
            
            NavigationLink(destination: ContentView(), isActive: $canLogout) {
                EmptyView()
            }
            .hidden()
            
            List{
                NavigationLink(destination: UserProfileView()){
                    Text("Profile")
                    EmptyView()
                }
                
            }
            
            Spacer()
            Text("Logout")
                .foregroundStyle(.selection)
                .font(.subheadline)
                .onTapGesture {
                    isAlertShowing.toggle()
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
        .alert(isPresented: $isAlertShowing, content: {
            Alert(title: Text("Logout"), message: Text("Are sure you want to log out?"), primaryButton: .default(Text("Yes")){
                userViewModel.logout{
                    canLogout = true
                    currentUserId = ""
                }
                
            }, secondaryButton: .cancel(Text("Cancel")))
        })
        
       
    }
}

#Preview {
    SettingsView()
}
