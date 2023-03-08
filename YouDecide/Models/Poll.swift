//
//  Question.swift
//  YouDecide
//
//  Created by Daniel Jones on 25/09/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Poll: Identifiable, Decodable {
    @DocumentID var id: String?
    let userId: String
    var questionText: String
    var answers: [Answer]?
    var timestamp: Timestamp
    
    var totalVoteCount: Int? {
        if let answers = answers {
            let answersVotes = answers.map{( $0.votes )}
            return answersVotes.reduce(0, +)
        } else {
            return 0
        }
    }
    
    var user: User?

}
