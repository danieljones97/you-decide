//
//  FeedView.swift
//  YouDecide
//
//  Created by Daniel Jones on 24/09/2022.
//

import SwiftUI

struct FeedView: View {
    
    @State private var showNewPollView = false
    @ObservedObject var viewModel: FeedViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(currentUserId: String) {
        self.viewModel = FeedViewModel(currentUserId: currentUserId)
    }
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    if let user = authViewModel.currentUser {
                        NavigationLazyView(FindFriendsView(currentUser: user))
                            .navigationBarHidden(true)
                    }
                } label: {
                    Image(systemName: "person.3.fill")
                        .padding(.leading)
                }
                
                Spacer()
                
                Text("YouDecide")
                    .font(.title2)
                
                Spacer()
                
                NavigationLink {
                    if let user = authViewModel.currentUser {
                        NavigationLazyView(ProfileView(user: user))
                            .navigationBarHidden(true)
                    }
                } label: {
                    Image(systemName: "person.fill")
                        .padding(.trailing)
                }
                
            }
            .foregroundColor(.white)
            
            ZStack(alignment: .bottomTrailing) {
                if (viewModel.polls.count > 0) {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.polls) { poll in
                                PollView(poll: poll)
                                    .padding(5)
                            }
                            
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("It's so empty in here...")
                            .padding()
                        Text("Go and follow some new people to see some stuff!")
                            .padding()
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                }
                
                Button {
                    showNewPollView.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 40, height: 40)
                        .padding()
                }
                .foregroundColor(Color.white)
                .padding()
                .fullScreenCover(isPresented: $showNewPollView, onDismiss: {
                    viewModel.fetchPolls()
                }) {
                    NewPollView()
                }

            }
        }.background(Color.black)
            .ignoresSafeArea(.all, edges: [.leading, .trailing])
            .navigationBarHidden(true)
            .navigationTitle("")
            .onAppear {
                viewModel.fetchPolls()
            }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
