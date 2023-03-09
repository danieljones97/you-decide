//
//  ProfileViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 08/03/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    private let userService = UserService()
    private let pollService = PollService()
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    
}
