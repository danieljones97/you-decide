//
//  FindFriends.swift
//  YouDecide
//
//  Created by Daniel Jones on 02/02/2023.
//

import SwiftUI

struct FindFriendsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = FindFriendsViewModel()
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }.padding(.leading, 10)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    Spacer()
                    Text("Find Friends")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                }
            }
            
            SearchBar(text: $viewModel.searchText)
                .padding(.horizontal)
            
            ScrollView {
                LazyVStack {
                    
                    ForEach(viewModel.searchedUsers) { user in
                        NavigationLink {
                            ProfileView(user: user)
                                .navigationBarHidden(true)
                        } label: {
                            UserRowView(user: user)
                        }
                    }
                }
            }
        }.background(Color.black)
            .ignoresSafeArea(.all, edges: [.leading, .trailing])
            .navigationBarHidden(true)
            .navigationTitle("")
    }
}

struct FindFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FindFriendsView().environmentObject(FindFriendsViewModel())
    }
}
