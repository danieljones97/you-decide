//
//  AuthViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 08/02/2023.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
//        var _ = Auth.auth().addStateDidChangeListener({ auth, user in
//            if let user = user {
//                Auth.auth().currentUser?.reload(completion: { error in
//                    if let error = error {
//                        print("DEBUG: reload failed - \(error)")
//                        self.userSession = nil
//                    } else {
//                        self.userSession = user
//                        self.fetchUser()
//                    }
//                })
//            } else {
//                self.userSession = nil
//            }
//        })

        
        Auth.auth().currentUser?.reload(completion: { error in
            if let error = error {
                print("DEBUG: reload failed - \(error)")
                self.userSession = nil
            } else {
                self.userSession = Auth.auth().currentUser
                self.fetchUser()
            }
        })
        
        
//        self.userSession = Auth.auth().currentUser
//        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login with error - \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, fullName: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error - \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullName": fullName,
                        "uid": user.uid,
                        "profileImageUrl": ""]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.fetchUser()
                }
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = userSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        print("DEBUG: Fetching user")
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
    
    
}
