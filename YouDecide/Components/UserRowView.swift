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
        }.background(Color.black)
            .foregroundColor(Color.white)
    }
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView(user: User(from: <#Decoder#>, username: "User", fullName: "User 1", profileImageUrl: "", email: "User@email.com"))
//    }
//}
