//
//  PollViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 08/03/2023.
//

import Foundation

class PollViewModel: ObservableObject {
    @Published var poll: Poll
    
    private let service = PollService()
    
    init(poll: Poll) {
        self.poll = poll
        checkIfUserVotedOnPoll()
    }
    
    func voteOnPoll(pollId: String, answerId: String) {
        service.voteOnPoll(pollId: pollId, answerId: answerId) {
            self.service.fetchAnswers(forPoll: pollId) { answers in
                self.poll.answers = answers
                
//                self.poll.didVote = true
                self.poll.votedAnswer = answerId
            }
        }
    }
    
    func checkIfUserVotedOnPoll() {
        service.checkIfUserVotedOnPoll(poll: poll) { answer in
            if answer != nil {
//                self.poll.didVote = true
                self.poll.votedAnswer = answer
            }
        }
    }
    
}
