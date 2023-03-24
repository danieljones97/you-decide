//
//  UserListView.swift
//  YouDecide
//
//  Created by Daniel Jones on 23/03/2023.
//

import SwiftUI

struct UserListView: View {
    var users = [User]()
    @State var searchText = ""
    var followedUsers = [String]()
    let currentUser: User
    let showFollowButton: Bool
    
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
    
    var body: some View {
        SearchBar(text: $searchText)
            .padding(.horizontal)
        
        ScrollView {
            LazyVStack {
                
                ForEach(searchedUsers) { user in
                    if (user.id != currentUser.id) {
                        NavigationLink {
                            ProfileView(user: user)
                                .navigationBarHidden(true)
                        } label: {
                            UserRowView(user: user, isFollowing: followedUsers.contains(user.id!), showFollowButton: showFollowButton)
                        }
                    }
                }
            }
        }
    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView(, currentUser)
//    }
//}
