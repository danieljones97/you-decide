//
//  FeedViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 06/03/2023.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var polls = [Poll]()
    
    let service = PollService()
    let userService = UserService()
    
    let currentUserId: String
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
        fetchPolls()
        checkFcmToken()
    }
    
    func fetchPolls() {
        userService.fetchFollowingUsersIds(userId: currentUserId) { followedUsers in
            
            self.service.fetchPolls(users: followedUsers) { polls in
                self.polls = polls
                
                for i in 0 ..< polls.count {
                    
                    //Fetch answers
                    let pollId = polls[i].id
                    self.service.fetchAnswers(forPoll: pollId!) { answers in
                        self.polls[i].answers = answers
                    }
                    
                    //Fetch user
                    let userId = polls[i].userId
                    self.userService.fetchUser(withUid: userId) { user in
                        self.polls[i].user = user
                    }
                    
                }
            }
        }
        
    }
    
    func checkFcmToken() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("DEBUG: Error fetching token - \(error)")
            } else if let token = token {
                print("DEBUG: VIEW MODEL - FCM registration token - \(token)")
                
                self.userService.updateUserFcmToken(userId: self.currentUserId, token: token)
            }
        }
        
    }
}
