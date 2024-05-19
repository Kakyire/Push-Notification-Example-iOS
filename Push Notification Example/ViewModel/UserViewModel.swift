//
//  UserManager.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 12/05/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject{
    
    @Published var userDetails:User? = nil
    @Published var otherUser:User? = nil
    @Published var isLoading = false
    @Published var errorMessage:String? = nil
   
    
    private let currentUserId = UserDefaults.standard.string(forKey: DefaultKeys.userId)

    
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    init(){
        if hasLoggedIn(){
            setupPresence()
        }
    }
    
    func login(withEmail email:String,password:String, onSuccess: @escaping (String)->Void) {
        isLoading = true
        auth.signIn(withEmail: email, password: password){authResult, error in
            
            guard authResult != nil else {
                if let error = error {
                    print("Error logging user:", error.localizedDescription)
                    self.errorMessage = error.localizedDescription
                } else {
                    print("Unknown error creating user")
                }
                self.isLoading = false
                return
            }
            if let userId = authResult?.user.uid {
                onSuccess(userId)
                self.isLoading = false
            }
        }
        
    }
    
    func createAccount(for user:User,onSuccess: @escaping (User)->Void) {
        isLoading = true
        auth.createUser(withEmail: user.email, password: user.password){authResult, error in
            
            guard let authResult = authResult else {
                if let error = error {
                    print("Error creating user:", error.localizedDescription)
                    self.errorMessage = error.localizedDescription
                } else {
                    print("Unknown error creating user")
                }
                self.isLoading = false
                return
            }
            
            self.isLoading = false
            self.userDetails = User(id: authResult.user.uid, name: user.name, email: user.email, image: user.image)
            onSuccess(self.userDetails!)
           

        }
    }
    
    
    func updateUser(details user:User)  {
        do {
            try firestore.collection(CollectionName.users)
                .document(user.id)
                .setData(from:user,merge: true)
        }catch {
            print("Error update: \(error)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    func hasLoggedIn() -> Bool{
        return auth.currentUser != nil
    }
    
    
    
    func logout(onSuccess:@escaping ()->Void)  {
        guard let currentUserId = currentUserId else { return }

        do {
            
            let userStatusRef = firestore.collection(CollectionName.users).document(currentUserId)
            let offlineStatus = ["nowAvailable": false, "lastActive": FieldValue.serverTimestamp()] as [String : Any]
           
            userStatusRef.setData(offlineStatus, merge: true)

            try auth.signOut()
            
            
            onSuccess()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            self.errorMessage = signOutError.localizedDescription

        }
        
    }
    
    func getUser() {
        
       
           firestore.collection(CollectionName.users)
                .document(currentUserId ?? "")
                .addSnapshotListener{querySnapshot, error in
                    guard let document = querySnapshot else {
                        print("Error fetching users: \(error)")
                        if let error = error{
                            self.errorMessage = error.localizedDescription

                        }
                        return
                    }
                    
                    self.userDetails = try? document.data(as: User.self)
                }
            
      
            
    }
    func getOtherUser(withId id:String) {
        
       
           firestore.collection(CollectionName.users)
                .document(id)
                .addSnapshotListener{querySnapshot, error in
                    guard let document = querySnapshot else {
                        print("Error fetching users: \(error)")
                        if let error = error{
                            self.errorMessage = error.localizedDescription
                        }
                        return
                    }
                    
                    self.otherUser = try? document.data(as: User.self)
                }
            
      
            
    }
    
  private  func setupPresence() {
        guard let currentUserId = currentUserId else { return }
        
       print("Setup we are here")
        let userStatusRef = firestore.collection(CollectionName.users).document(currentUserId)
        let onlineStatus = ["nowAvailable": true,"lastActive": FieldValue.serverTimestamp() ] as [String : Any]
        let offlineStatus = ["nowAvailable": false, "lastActive": FieldValue.serverTimestamp()] as [String : Any]
        
        // Set the status to online when the app starts
        userStatusRef.setData(onlineStatus, merge: true)
        
        // Set the status to offline when the app is terminated
//        Firestore.firestore().disableNetwork { _ in
//            userStatusRef.setData(offlineStatus, merge: true)
//        }
        
        // Set the status to online when the app is foregrounded
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
            userStatusRef.setData(onlineStatus, merge: true)
        }
//        
//        // Set the status to offline when the app is backgrounded
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
            userStatusRef.setData(offlineStatus, merge: true)
        }
    }
}
