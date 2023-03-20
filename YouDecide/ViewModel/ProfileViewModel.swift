//
//  ProfileViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 08/03/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var polls = [Poll]()
    
    private let userService = UserService()
    private let pollService = PollService()
    
    let user: User
    @Published var isFollowing: Bool = false
    
    init(user: User) {
        self.user = user
        self.checkIfFollowing()
        self.fetchUserPolls()
    }
    
    func fetchUserPolls () {
        guard let userId = user.id else { return }
        pollService.fetchPolls(forUser: userId) { polls in
            self.polls = polls
            
            for i in 0 ..< polls.count {
                
                //Fetch answers
                let pollId = polls[i].id
                self.pollService.fetchAnswers(forPoll: pollId!) { answers in
                    self.polls[i].answers = answers
                }
                
                //Fetch user
                self.polls[i].user = self.user
                
            }
        }
    }
    
    func followUser() {
        userService.followUser(userId: self.user.id!) { success in
            self.isFollowing = true
        }
    }
    
    func unfollowUser() {
        userService.unfollowUser(userId: self.user.id!) { success in
            self.isFollowing = false
        }
    }
    
    func checkIfFollowing() {
        userService.checkIfFollowing(userId: user.id!) { isFollowing in
            self.isFollowing = isFollowing
        }
    }
}
