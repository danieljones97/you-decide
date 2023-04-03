//
//  UserVoteListView.swift
//  YouDecide
//
//  Created by Daniel Jones on 31/03/2023.
//

import SwiftUI

struct UserVoteListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: UserVoteListViewModel
    
    init(answerId: String) {
        self.viewModel = UserVoteListViewModel(answerId: answerId)
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
                }
            }
            
//            ForEach(viewModel.searchedUsers) { user in
//                NavigationLink {
//                    ProfileView(user: user)
//                        .navigationBarHidden(true)
//                } label: {
//                    UserRowView(user: user, isFollowing: viewModel.followedUsers.contains(user.id!), showFollowButton: true)
//                }
//
//            }
            
            UserListView(users: viewModel.users, followedUsers: viewModel.followedUsers, currentUser: viewModel.currentUser, showFollowButton: true)
            
        }
        .background(Color.black)
        .ignoresSafeArea(.all, edges: [.leading, .trailing])
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

//
//struct UserVoteListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserVoteListView()
//    }
//}
