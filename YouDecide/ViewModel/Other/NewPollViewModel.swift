//
//  NewPollViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 05/03/2023.
//

import Foundation

class NewPollViewModel: ObservableObject {
    @Published var didUploadPoll = false
    let service = PollService()
    
    func createPoll(withQuestionText questionText: String, answersTexts: [String]) {
        service.createPoll(questionText: questionText, answersTexts: answersTexts) { success in
            if success {
                self.didUploadPoll = true
            } else {
                // display error?
            }
        }
    }
}
