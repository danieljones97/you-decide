//
//  UserService.swift
//  YouDecide
//
//  Created by Daniel Jones on 16/02/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                
                completion(users)
            }
    }
    
    func fetchFollowingUsers(userId: String, completion: @escaping([String]) -> Void) {
        
        Firestore.firestore().collection("user-followers")
            .whereField("followerUserId", isEqualTo: userId)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.get("userId") as? String })

                completion(users)
            }
    }
    
    func fetchFollowingUsersCount(userId: String, completion: @escaping(Int) -> Void) {
        
        Firestore.firestore().collection("user-followers")
            .whereField("followerUserId", isEqualTo: userId)
            .getDocuments { snapshot, _ in
                completion(snapshot?.documents.count ?? 0)
            }
    }
    
    func fetchFollowerUsersCount(userId: String, completion: @escaping(Int) -> Void) {
        
        Firestore.firestore().collection("user-followers")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, _ in
                completion(snapshot?.documents.count ?? 0)
            }
    }
    
    func followUser(userId: String, completion: @escaping(Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let userFollowerData = ["userId": userId,
                            "followerUserId": currentUserId]
        Firestore.firestore().collection("user-followers").document().setData(userFollowerData) { _ in
            completion(true)
        }
    }
    
    func unfollowUser(userId: String, completion: @escaping(Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user-followers")
            .whereField("userId", isEqualTo: userId)
            .whereField("followerUserId", isEqualTo: currentUserId)
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents.first else { return }
                document.reference.delete()
                completion(true)
                
            }
    }
    
    func checkIfFollowing(userId: String, completion: @escaping(Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("user-followers")
            .whereField("userId", isEqualTo: userId)
            .whereField("followerUserId", isEqualTo: currentUserId)
            .getDocuments { snapshot, _ in
                guard let document = snapshot?.documents.first else { return }
                completion(document.exists)
            }
    }
}
