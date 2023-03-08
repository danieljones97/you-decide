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
    
    func fetchPolls(completion: @escaping([Poll]) -> Void) {
        
        Firestore.firestore().collection("polls").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            var polls = documents.compactMap({ try? $0.data(as: Poll.self )})
            
            completion(polls)
            
            //DJTODO - This might not assign the variable correctly according got google, might need to do index
            //Google error "Cannot assign to property is a let constant for loop"
            
            let dispatchGroup = DispatchGroup()
            
            for i in polls.indices {
                dispatchGroup.enter()

                Firestore.firestore().collection("answers").whereField("pollId", isEqualTo: polls[i].id)
                    .getDocuments { snapshot, error in

                        guard let answersDocuments = snapshot?.documents else { return }

                        let answers = answersDocuments.compactMap({ try? $0.data(as: Answer.self)})

                        polls[i].answers = answers

                        dispatchGroup.leave()
                    }
            }

            dispatchGroup.notify(queue: .main) {
                completion(polls)
            }
            
        }

    }
    
}
