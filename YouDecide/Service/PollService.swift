//
//  PollService.swift
//  YouDecide
//
//  Created by Daniel Jones on 03/03/2023.
//

import Foundation
import Firebase

struct PollService {
    
    func createPoll(questionText: String, answersTexts: [String], completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["userId": uid,
                    "questionText": questionText,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("polls").addDocument(data: data) { error in
            if let error = error {
                completion(false)
                print("DEBUG: Failed to upload poll with error - \(error.localizedDescription)")
            } else {
                
                let pollId = ref!.documentID
                answersTexts.forEach { answer in
                    let answerData = ["pollId": pollId,
                                      "answerText": answer,
                                      "votes": 0]
                    Firestore.firestore().collection("answers").addDocument(data: answerData) { answerError in
                        if let answerError = answerError {
                            print("DEBUG: Failed to upload answers with error - \(answerError.localizedDescription)")
                            completion(false)
                            
                            //NEED TO DELETE NEW POLL?
                        }
                    }
                    
                }
                
                completion(true)
                
            }
        }
        
    }
    
    func fetchAnswers(forPoll pollId: String, completion: @escaping([Answer]) -> Void) {
        Firestore.firestore().collection("answers")
            .whereField("pollId", isEqualTo: pollId)
            .getDocuments { snapshot, _ in
                
            guard let documents = snapshot?.documents else { return }
            
            var answers = documents.compactMap({ try? $0.data(as: Answer.self )})
            
            completion(answers)
            
        }
    }
    
    func fetchPolls(users: [String], completion: @escaping([Poll]) -> Void) {
        if (users.count == 0) {
            completion([Poll]())
        } else {
            
            Firestore.firestore().collection("polls")
                .whereField("userId", in: users)
                .getDocuments { snapshot, _ in
                    
                    guard let documents = snapshot?.documents else { return }
                    
                    let polls = documents.compactMap({ try? $0.data(as: Poll.self )})
                    
                    completion(polls.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                    
                }
        }
    }
    
    func fetchPolls(forUser userId: String, completion: @escaping([Poll]) -> Void) {
        
        Firestore.firestore().collection("polls")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, _ in
                
            guard let documents = snapshot?.documents else { return }
            
            let polls = documents.compactMap({ try? $0.data(as: Poll.self )})
                
            completion(polls.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            
        }
    }
    
    func voteOnPoll(pollId: String, answerId: String, completion: @escaping() -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        //Update answer votes
        Firestore.firestore().collection("answers").document(answerId)
            .updateData(["votes": FieldValue.increment(Int64(1))]) { _ in
                
                //Update user votes table
                let userVoteData = ["userId": userId,
                                    "pollId": pollId,
                                    "answerId": answerId]
                Firestore.firestore().collection("user-votes").document().setData(userVoteData) { _ in
                    completion()
                }
            }
        
    }
    
    func checkIfUserVotedOnPoll(poll: Poll, completion: @escaping(String?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let pollId = poll.id else { return }
        
        Firestore.firestore().collection("user-votes")
            .whereField("pollId", isEqualTo: pollId)
            .whereField("userId", isEqualTo: userId)
            .getDocuments(completion: { snapshot, _ in
                guard let document = snapshot?.documents.first else { return }
                
                guard let answerId = document.get("answerId") as? String else { return }
                completion(answerId)
            })
        
    }
    
    func fetchUsersIdsWhoVotedOnAnswer(answerId: String, completion: @escaping([String]) -> Void) {
        Firestore.firestore().collection("user-votes")
            .whereField("answerId", isEqualTo: answerId)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let users = documents.compactMap({ try? $0.get("userId") as? String })

                completion(users)
            }
    }
    
}
