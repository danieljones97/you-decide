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
    
    init(user: User, isFollowing: Bool) {
        self.user = user
        self.isFollowing = isFollowing
    }
    
    func followUser() {
        service.followUser(userId: self.user.id!) { success in
            self.isFollowing = true
            //Need to trigger find friends view model to go and fetch followed users
        }
    }
}
