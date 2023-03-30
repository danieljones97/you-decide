//
//  FollowerListViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 23/03/2023.
//

import Foundation

class FollowListViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    @Published var followedUsers = [String]()
    let user: User
    let isFollowingList: Bool
    
    var searchedUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.fullName.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    let service = UserService()
    
    init(user: User, isFollowingList: Bool) {
        self.user = user
        self.isFollowingList = isFollowingList
        
        if (isFollowingList) {
            fetchFollowing()
        } else {
            fetchFollowers()
            fetchFollowedUsersIds()
        }
    }
    
    func fetchFollowers() {
        service.fetchFollowersUsersIds(userId: user.id!) { usersIds in
            if (usersIds.count > 0) {
                self.service.fetchUsers(withUids: usersIds) { users in
                    self.users = users
                }
            }
        }
    }
    
    func fetchFollowing() {
        service.fetchFollowingUsersIds(userId: user.id!) { usersIds in
            self.followedUsers = usersIds
            
            if (usersIds.count > 0) {
                self.service.fetchUsers(withUids: usersIds) { users in
                    self.users = users
                }
            }
        }
    }
    
    func fetchFollowedUsersIds() {
        service.fetchFollowingUsersIds(userId: user.id!) { users in
            self.followedUsers = users
        }
    }
    
}
