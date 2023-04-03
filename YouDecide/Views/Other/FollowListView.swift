//
//  FindFriends.swift
//  YouDecide
//
//  Created by Daniel Jones on 02/02/2023.
//

import SwiftUI

struct FollowListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FollowListViewModel
    
    init(user: User, isFollowingList: Bool) {
        self.viewModel = FollowListViewModel(user: user, isFollowingList: isFollowingList)
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
                    if (viewModel.isFollowingList) {
                        Text("\(viewModel.user.username)'s Following")
                            .foregroundColor(Color.white)
                            .font(.title2)
                    } else {
                        Text("\(viewModel.user.username)'s Followers")
                            .foregroundColor(Color.white)
                            .font(.title2)
                    }
                }
            }
            
            UserListView(users: viewModel.users, followedUsers: viewModel.followedUsers, currentUser: viewModel.user, showFollowButton: true, showCurrentUser: false)
            
        }.background(Color.black)
            .ignoresSafeArea(.all, edges: [.leading, .trailing])
            .navigationBarHidden(true)
            .navigationTitle("")
            .onAppear {
                self.viewModel.fetchFollowers()
                self.viewModel.fetchFollowedUsersIds()
            }
    }
}

//
//struct FindFriendsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FindFriendsView().environmentObject(FindFriendsViewModel())
//    }
//}
