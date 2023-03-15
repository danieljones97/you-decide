//
//  UserRowView.swift
//  YouDecide
//
//  Created by Daniel Jones on 28/02/2023.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    
    let user: User
    
    var body: some View {
        HStack {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(10)
            Text(user.username)
            Spacer()
            
            Button {
                print("FOLLOW \(user.fullName)")
            } label: {
                Text("Follow")
                    .foregroundColor(Color.white)
                    .frame(alignment: .trailing)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .font(.caption)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white, lineWidth: 1))
            }
            .padding(.trailing)
            
        }.background(Color.black)
            .foregroundColor(Color.white)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(id: "", username: "User", fullName: "User 1", profileImageUrl: "", email: "User@email.com"))
    }
}
