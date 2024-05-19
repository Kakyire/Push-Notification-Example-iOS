//
//  SignUpView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 11/05/2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @FocusState var isInputActive: Bool
    
    @AppStorage(DefaultKeys.userId) var currentUserId = ""
    
    @State var canLogin = false
    @State var isRemoteError = false
    @State var isFieldError = false
    @State var errorMessage = ""
    
    @ObservedObject private var userViewModel = UserViewModel()
    @State private var user:User? = nil
    
    var body: some View {
        ScrollView {
            VStack (spacing:10){
                Text("Sign up with Email")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.deepBlue)
                    .padding(.vertical)
                
                Text("Get chatting with friends and family today by signing up for our chat app!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                //user details
                VStack(alignment:.leading){
                    //name
                    Text("Your name")
                        .multilineTextAlignment(.leading)
                    TextField("", text: $name)
                        .padding()
                        .textContentType(.name)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        .focused($isInputActive)
                        .cornerRadius(10)
                    //                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    
                    //email
                    Text("Your email")
                        .multilineTextAlignment(.leading)
                    TextField("", text: $email)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        .focused($isInputActive)
                    //                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    
                    
                    
                    
                    //password
                    Text("Password")
                    
                    SecureField("", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        .focused($isInputActive)
                    //                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    
                    
                    //password
                    Text("Confirm Password")
                    SecureField("", text: $confirmedPassword)
                        .textContentType(.password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        .focused($isInputActive)
                    //                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    
                }.padding(.top,16)
                
                Spacer()
                
                //create account
                HStack{
                    Spacer()
                    if userViewModel.isLoading{
                        ProgressView()
                    }else{
                        Text("Create Account")
                            .foregroundColor(.primary)
                            .colorInvert()
                            .font(.title3)
                    }
                    Spacer()
                }.padding()
                    .padding(.vertical,0)
                    .background(.deepBlue)
                    .cornerRadius(16)
                    .onTapGesture {
                        
                        validateFields()
                        if !isFieldError{
                            if !userViewModel.isLoading{
                                let user = User(name: name, email: email,password: password )
                                
                                userViewModel.createAccount(for: user, onSuccess: {userDetails in
                                    
                                    userViewModel.updateUser(details: userDetails)
                                    currentUserId = userDetails.id
                                    canLogin = true
                                })
                            }
                        }
                        
                        
                    }
                
                NavigationLink(destination:ChatsView(),isActive: $canLogin) {
                    EmptyView()
                }.hidden()
                
                
                
                
            }.safeAreaPadding()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton())
                .onTapGesture {
                    isInputActive = false
                }
            
        }
        .onChange(of: userViewModel.errorMessage){ error in
            isRemoteError = error != nil
            errorMessage = error ?? "Something went wrong"
        }
        .toast(isPresented: $isFieldError, message: errorMessage){
            errorMessage = ""
        }
        .padding(.horizontal,10)
        
    }
    
    private func validateFields(){
        if name.isEmpty {
            errorMessage = "Name field is required"
        }else if email.isEmpty{
            errorMessage = "Email field required"
        }else if !email.isValidEmail(){
            errorMessage = "Enter valid email"
        }else if password.isEmpty {
            errorMessage = "Password field required"
        } else if password != confirmedPassword{
            errorMessage = "Password do not match"
        }else if password.count < 6 {
            errorMessage = "Password length should be 6 or more"
        }
        
        print("password length \(password):\(password.count)")
        print("confirmation length \(confirmedPassword):\(confirmedPassword.count)")
        isFieldError = !errorMessage.isEmpty
    }
    
}

#Preview {
    SignUpView()
}
