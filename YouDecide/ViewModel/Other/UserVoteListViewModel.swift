//
//  UserVoteListViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 01/04/2023.
//

import Foundation

class UserVoteListViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    @Published var followedUsers = [String]()
    var currentUserId: String
    var currentUser = User(username: "", fullName: "", profileImageUrl: "", email: "")
    
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
    let pollService = PollService()
    
    init(answerId: String) {
        currentUserId = service.fetchCurrentUserId()
        service.fetchUser(withUid: currentUserId) { user in
            self.currentUser = user
        }
        
        fetchUsersWhoVoted(answerId: answerId)
        //fetchFollowedUsersIds()
    }
    
    func fetchUsersWhoVoted(answerId: String) {
        pollService.fetchUsersIdsWhoVotedOnAnswer(answerId: answerId) { usersIds in
            if usersIds.count > 0 {
                self.service.fetchUsers(withUids: usersIds) { users in
                    self.users = users
                }
            }
        }
    }
    
    func fetchFollowedUsersIds() {
        service.fetchFollowingUsersIds(userId: currentUserId) { users in
            self.followedUsers = users
        }
    }
    
}
