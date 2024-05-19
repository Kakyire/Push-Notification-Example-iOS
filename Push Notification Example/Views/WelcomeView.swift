//
//  WelcomeView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 11/05/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            Color.darkBlueCustom
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
                .overlay(
                    
                    ScrollView {
                        VStack(alignment:.leading,spacing: 16){
                            Spacer()
                            Text("Connect friends easily & quickly")
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 60))
                                .foregroundStyle(.windowBackground)
                                .padding()
                            
                            Text("Our chat app is the perfect way to stay connected with friends and family.")
                                .foregroundStyle(.background)
                                .opacity(0.5)
                                .padding(.horizontal)
                            
                            //sign in options
                            HStack(alignment:.center,spacing:16){
                                Spacer()
                                Image("facebook")
                                    .padding()
                                    .background(.secondary)
                                    .clipShape(Circle())
                                
                                Image("google")
                                    .padding()
                                    .background(.secondary)
                                    .clipShape(Circle())
                                
                                Image("apple")
                                    .renderingMode(.template)
                                    .padding()
                                    .foregroundColor(.primary)
                                    .colorInvert()
                                    .background(.secondary)
                                    .clipShape(Circle())
                                
                                Spacer()
                                
                            }.padding(.vertical,16)
                            
                            //or
                            HStack{
                                Rectangle()
                                    .fill()
                                    .frame(height: 1)
                                    .colorInvert()
                                
                                Text("OR")
                                    .font(.title)
                                    .colorInvert()
                                    .padding(.horizontal,10)
                                
                                Rectangle()
                                    .fill()
                                    .frame(height: 1)
                                    .colorInvert()
                                
                            }.padding(.horizontal)
                            
                            //sign up
                            NavigationLink(destination:SignUpView()) {
                                HStack (alignment:.center){
                                    Spacer()
                                    Text("Sign up with mail")
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .colorInvert()
                                .padding()
                                .background(Color.white.opacity(0.37))
                                .cornerRadius(10)
                            .padding(.horizontal,10)
                            }
                            
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Existing account?")
                                    .colorInvert()
                                NavigationLink(destination: LoginView()){
                                    Text("Log in")
                                        .foregroundStyle(.black)
                                        .fontWeight(.bold)
                                        .colorInvert()
                                }
                                Spacer()
                            }
                            Spacer()
                            
                            
                        }.padding(.horizontal,8)
                    }
                )
            
        }                 

        
        
        
        
    }
}

#Preview {
    WelcomeView()
}
