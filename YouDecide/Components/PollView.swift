//
//  Poll.swift
//  YouDecide
//
//  Created by Daniel Jones on 24/09/2022.
//

import SwiftUI
import Kingfisher
import Firebase

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
                    
                    NavigationLink {
                        ProfileView(user: user)
                            .navigationBarHidden(true)
                    } label: {
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
                                
                                if viewModel.poll.votedAnswer == answer.id {
                                    Image(systemName: "checkmark.circle")
                                }
                                
                                Text(answer.answerText).frame(minWidth: 0, maxWidth: UIScreen.main.bounds.size.width - 120, alignment: .leading).layoutPriority(1)
                                
                                if viewModel.poll.votedAnswer == nil {
                                    Spacer()
                                    Button {
                                        viewModel.voteOnPoll(pollId: viewModel.poll.id!, answerId: answer.id!)
                                    } label: {
                                        Text("Vote")
                                            .foregroundColor(Color.white)
                                            .frame(alignment: .trailing)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 3)
                                            .font(.caption)
                                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white, lineWidth: 1))
                                    }
                                } else {
                                    ProgressView(value: answer.calculateVotePercentage(voteCount: answer.votes, totalVoteCount: viewModel.poll.totalVoteCount!)).frame(minWidth: UIScreen.main.bounds.size.width/4, maxWidth: .infinity,alignment: .trailing)
                                    Text(String(answer.votes) + " votes").layoutPriority(1)
                                }


                                
                            }.padding(.vertical, 5)
                                .animation(Animation.easeIn, value: viewModel.poll.votedAnswer ?? nil)
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

struct PollView_Previews: PreviewProvider {
    static var previews: some View {
        PollView(poll: Poll(userId: "UserID", questionText: "This is a test of a really long question title to see whether it breaks the UI", answers: [Answer(pollId: "PollID", answerText: "This is a ", votes: 2)], timestamp: Timestamp()))
    }
}
