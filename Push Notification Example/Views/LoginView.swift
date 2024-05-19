//
//  LoginView.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 10/05/2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @AppStorage(DefaultKeys.userId) var currentUserId = ""
    
    @State private var email = ""
    @State private var password = ""
    @FocusState var isInputActive: Bool
    
    @State var canLogin = false
    @State var isRemoteError = false
    @State var isFieldError = false
    @State var errorMessage = ""
    @ObservedObject private var userViewModel = UserViewModel()
    
    var body: some View {
        ScrollView {
            VStack (spacing:10){
                Text("Log in to Chatbox")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.deepBlue)
                    .padding(.vertical)
                
                Text("Welcome back! Sign in using your social account or email to continue us")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                //sign in options
                HStack(alignment:.center,spacing:16){
                    Spacer()
                    Image("facebook")
                        .padding()
                    
                    Image("google")
                        .padding()
                    
                    Image("apple")
                        .colorInvert()
                        .padding()
                    
                    Spacer()
                    
                }.padding(.vertical,16)
                
                
                //or
                HStack{
                    Rectangle()
                        .fill(.separator)
                        .frame(height: 1)
                    
                    Text("OR")
                        .font(.largeTitle)
                        .padding(.horizontal,10)
                    
                    Rectangle()
                        .fill(.separator)
                        .frame(height: 1)
                    
                    
                }.padding(.horizontal)
                
                //email and password
                VStack(alignment:.leading){
                    //email
                    Text("Your email")
                        .multilineTextAlignment(.leading)
                    TextField("", text: $email)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .padding()
                        .focused($isInputActive)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    
                    
                    
                    //password
                    Text("Password")
                    SecureField("", text: $password)
                        .padding()
                        .focused($isInputActive)
                        .textContentType(.password)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                }
                
                Spacer()
                
                //login
                HStack{
                    Spacer()
                    if userViewModel.isLoading{
                        ProgressView()
                    }else{
                        Text("Log in")
                    }
                    Spacer()
                }
                .foregroundColor(.primary)
                .colorInvert()
                .padding()
                .background(.deepBlue)
                .cornerRadius(16)
                .onTapGesture {
                    
                   validateFields()
                    if !isFieldError{
                        if !userViewModel.isLoading{
                            userViewModel.login(withEmail: email, password: password, onSuccess: {userId in
                                canLogin = true
                                currentUserId = userId
                                
                            })
                        }
                    }
                    
                }
                
                Text("Forgot password?")
                
                
                Spacer()
                
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
        .alert(isPresented: $isRemoteError, content: {
            Alert(title: Text("Error"),message: Text(errorMessage),dismissButton: .default(Text("OK"), action: {
                isRemoteError = false
                userViewModel.errorMessage = nil
            }))
        })
        .padding(.horizontal,10)
        
    }
    
   private func validateFields(){
        if email.isEmpty{
            errorMessage = "Email field cannot be empty"
        }else if password.isEmpty {
            errorMessage = "Password field cannot be empty"
        } else if !email.isValidEmail(){
            errorMessage = "Enter valid email"
        }else if password.count < 6 {
            errorMessage = "Password length should be 6 or more"
        }
    
        isFieldError = !errorMessage.isEmpty
    }
}

#Preview {
    LoginView()
}
