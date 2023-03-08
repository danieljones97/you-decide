//
//  Poll.swift
//  YouDecide
//
//  Created by Daniel Jones on 24/09/2022.
//

import SwiftUI
import Kingfisher

struct PollView: View {
    
    @ObservedObject var viewModel: PollViewModel
    
    init(poll: Poll) {
        self.viewModel = PollViewModel(poll: poll)
    }
    
    var body: some View {
        VStack {
            
            //Profile Info
            HStack {
                if let user = viewModel.poll.user {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                    
                    HStack {
                            Text(user.username)
                                .padding(.leading)
                            Spacer()
                            Text("Date")
                                .font(.footnote)
                                .fontWeight(.light)
                    }
                } else {
                    ProgressView()
                }
                
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            //Poll content
            VStack (alignment: .leading) {
                //Question
                HStack {
                    Text(viewModel.poll.questionText)
                }
                
                //Answers
                LazyVStack {
                    
                    if let answers = viewModel.poll.answers {
                        
                        ForEach(answers) { answer in
                            HStack {
                                Text(answer.answerText).frame(maxWidth: UIScreen.main.bounds.size.width/2, alignment: .leading)
                                ProgressView(value: answer.calculateVotePercentage(voteCount: answer.votes, totalVoteCount: viewModel.poll.totalVoteCount!)).frame(maxWidth: UIScreen.main.bounds.size.width/2, alignment: .trailing)
                                Text(String(answer.votes) + " votes")
                            }
                        }
                        
                    } else {
                        ProgressView()
                    }
                }
                
            }.padding()
            Divider().background()
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)).background(.black).foregroundColor(.white)
            
    }
}

//struct PollView_Previews: PreviewProvider {
//    static var previews: some View {
//        PollView(username: "Username", userProfileImageUrl: "", dateCreated: "01-01-2020", poll: Poll(questionText: "Question 1", answers: [Answer(answerText: "Answer 1", voteCount: 2), Answer(answerText: "Answer 2", voteCount: 4)]))
//    }
//}
