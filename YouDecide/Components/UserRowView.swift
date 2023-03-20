//
//  UserRowView.swift
//  YouDecide
//
//  Created by Daniel Jones on 28/02/2023.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    
    @ObservedObject var viewModel: UserRowViewModel
    
    init(user: User, isFollowing: Bool) {
        self.viewModel = UserRowViewModel(user: user, isFollowing: isFollowing)
    }
    
    var body: some View {
        HStack {
            KFImage(URL(string: viewModel.user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(10)
            Text(viewModel.user.username)
            Spacer()
            
            if (viewModel.isFollowing) {
                Button {
                    viewModel.unfollowUser()
                } label: {
                    Text("Following")
                        .foregroundColor(Color.white)
                        .frame(alignment: .trailing)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .font(.caption)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white, lineWidth: 1))
                        .padding(.trailing)
                }
                
            } else {
                Button {
                    viewModel.followUser()
                } label: {
                    Text("Follow")
                        .foregroundColor(Color.white)
                        .frame(alignment: .trailing)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .font(.caption)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white, lineWidth: 1))
                        .padding(.trailing)
                }
                
            }
            
        }.background(Color.black)
            .foregroundColor(Color.white)
    }
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView(user: User(id: "", username: "User", fullName: "User 1", profileImageUrl: "", email: "User@email.com"))
//    }
//}
