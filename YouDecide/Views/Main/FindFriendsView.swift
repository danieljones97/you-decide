//
//  FindFriends.swift
//  YouDecide
//
//  Created by Daniel Jones on 02/02/2023.
//

import SwiftUI

struct FindFriendsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FindFriendsViewModel
    
    init(currentUser: User) {
        self.viewModel = FindFriendsViewModel(currentUser: currentUser)
    }
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }.padding(.leading, 10)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    Spacer()
                    Text("Find Friends")
                        .foregroundColor(Color.white)
                        .font(.title2)
                }
            }
            
            UserListView(users: viewModel.users, followedUsers: viewModel.followedUsers, currentUser: viewModel.currentUser, showFollowButton: true)
            
//            SearchBar(text: $viewModel.searchText)
//                .padding(.horizontal)
//
//            ScrollView {
//                LazyVStack {
//
//                    ForEach(viewModel.searchedUsers) { user in
//                        if (user.id != viewModel.currentUser.id) {
//                            NavigationLink {
//                                ProfileView(user: user)
//                                    .navigationBarHidden(true)
//                            } label: {
//                                UserRowView(user: user, isFollowing: viewModel.followedUsers.contains(user.id!))
//                            }
//                        }
//                    }
//                }
//            }
        }.background(Color.black)
            .ignoresSafeArea(.all, edges: [.leading, .trailing])
            .navigationBarHidden(true)
            .navigationTitle("")
            .onAppear {
                self.viewModel.fetchFollowedUsers()
            }
    }
}

//
//struct FindFriendsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FindFriendsView().environmentObject(FindFriendsViewModel())
//    }
//}
