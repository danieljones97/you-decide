//
//  FeedViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 06/03/2023.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var polls = [Poll]()
    
    let service = PollService()
    let userService = UserService()
    
    init() {
        fetchPolls()
    }
    
    func fetchPolls() {
        
        service.fetchPolls { polls in
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
