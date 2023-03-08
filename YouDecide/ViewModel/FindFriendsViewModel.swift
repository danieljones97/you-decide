//
//  FindFriendsViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 28/02/2023.
//

import Foundation

class FindFriendsViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
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
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
    
}
