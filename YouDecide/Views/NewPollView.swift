//
//  NewPollView.swift
//  YouDecide
//
//  Created by Daniel Jones on 02/03/2023.
//

import SwiftUI
import Kingfisher

struct NewPollView: View {
    
    @State private var PollTitle: String = ""
    
    @State var answers: [String] = ["", ""]
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = NewPollViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.black)
                }
                
                Spacer()
                
                Button {
                    viewModel.createPoll(withQuestionText: PollTitle, answersTexts: answers)
                } label: {
                    Text("Post")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(Capsule())
                }
                
            }
            .padding()
            
            VStack {
                HStack {
                    
                    if let user = authViewModel.currentUser {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .padding(.horizontal)
                    }
                    
                    CustomInputField(imageName: "questionmark", placeholderText: "Question", text: $PollTitle)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                VStack {
                    
                    ForEach(0..<answers.count, id: \.self) { index in
                        CustomInputField(imageName: "checkmark", placeholderText: "Answer", text: self.$answers[index])
                            .padding(.bottom, 20)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                if (answers.count < 6) {
                    Button {
                        self.answers.append("")
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add answer")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .foregroundColor(Color.black)
                    }
                }
                
                Spacer()
                
            }
        }
        .ignoresSafeArea(.all, edges: [.leading, .trailing])
        .onReceive(viewModel.$didUploadPoll) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewPollView_Previews: PreviewProvider {
    static var previews: some View {
        NewPollView()
            .environmentObject(AuthViewModel())
    }
}
