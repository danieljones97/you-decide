//
//  UserRowViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 16/03/2023.
//

import Foundation

class UserRowViewModel: ObservableObject {
    
    private let service = UserService()
    
    let user: User
    @Published var isFollowing: Bool
    let showFollowButton: Bool
    
    init(user: User, isFollowing: Bool, showFollowButton: Bool) {
        self.user = user
        self.isFollowing = isFollowing
        self.showFollowButton = showFollowButton
    }
    
    func followUser() {
        service.followUser(userId: self.user.id!) { success in
            self.isFollowing = true
        }
    }
    
    func unfollowUser() {
        print("DEBUG: Unfollowing")
        service.unfollowUser(userId: self.user.id!) { success in
            self.isFollowing = false
        }
    }
}
