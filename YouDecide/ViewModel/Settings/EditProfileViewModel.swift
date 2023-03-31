//
//  EditProfileViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 31/03/2023.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    
    @Published var showError = false
    @Published var didUpdateUser = false
    
    @Published var fullName: String
    @Published var username: String
    @Published var email: String
    private var userId: String
    
    init(user: User) {
        self.userId = user.id!
        self.fullName = user.fullName
        self.username = user.username
        self.email = user.email
    }

    let service = UserService()
    
    func save() {
        service.updateUser(id: userId, username: username, email: email, fullName: fullName) { success in
            if success {
                self.didUpdateUser = true
            } else {
                self.showError = true
            }
        }
    }
    
}
