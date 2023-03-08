//
//  User.swift
//  YouDecide
//
//  Created by Daniel Jones on 16/02/2023.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullName: String
    let profileImageUrl: String
    let email: String
}
