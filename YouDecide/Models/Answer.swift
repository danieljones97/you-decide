//
//  AnswerStruct.swift
//  YouDecide
//
//  Created by Daniel Jones on 24/09/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Answer: Identifiable, Decodable {
    @DocumentID var id: String?
    let pollId: String
    var answerText: String
    var votes: Int
    
    func calculateVotePercentage(voteCount: Int, totalVoteCount: Int) -> Double {
        let perc = (Float64(voteCount)/Double(totalVoteCount))
        return perc.isNaN ? 0.0 : perc
    }
}
