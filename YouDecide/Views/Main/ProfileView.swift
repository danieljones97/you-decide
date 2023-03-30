//
//  ProfileView.swift
//  YouDecide
//
//  Created by Daniel Jones on 12/10/2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        var firstName = viewModel.user.fullName.components(separatedBy: " ")[0]
        
        VStack {
            VStack {
                
                NavigationLink {
                    ProfilePhotoSelectorView()
                        .navigationBarHidden(true)
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        KFImage(URL(string: viewModel.user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 72, height: 72)
                        
                        Image(systemName: "camera")
                            .resizable()
                            .frame(width: 12, height: 10)
                            .foregroundColor(.black)
                            .padding(5)
                            .background(Color.white)
                            .clipShape(Circle())
                            .font(.footnote)
                    }
                }
                
                Text(viewModel.user.fullName).font(.title)
                Text("@\(viewModel.user.username)").foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    
                    NavigationLink {
                        NavigationLazyView(FollowListView(user: viewModel.user, isFollowingList: true))
                    } label: {
                        Text("\(viewModel.userFollowingCount)")
                            .fontWeight(.bold)
                        Text("following")
                            .padding(.trailing)
                    }
                    
                    NavigationLink {
                        NavigationLazyView(FollowListView(user: viewModel.user, isFollowingList: false))
                    } label: {
                        Text("\(viewModel.userFollowerCount)")
                            .fontWeight(.bold)
                            .padding(.leading)
                        Text("followers")
                    }
                    
                }
                .padding(.top, 1)
                
            }
            .padding(.top, 40)
            .frame(width: UIScreen.main.bounds.size.width)
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        
                        if (viewModel.user.id == authViewModel.currentUser?.id) {
                            NavigationLink {
                                SettingsView()
                                        .navigationBarHidden(true)
                            } label: {
                                Text("Settings")
                                Image(systemName: "gearshape.fill")
                            }
                            .padding(10)
                            
                        } else {
                            if (viewModel.isFollowing) {
                                Button {
                                    viewModel.unfollowUser()
                                } label: {
                                    Text("Unfollow")
                                        .padding(10)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(20)
                                        .padding(.horizontal, 5)
                                }
                            } else {
                                Button {
                                    viewModel.followUser()
                                } label: {
                                    Text("Follow")
                                        .padding(10)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(20)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                    }
                    Spacer()
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
            .overlay {
                VStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .padding(8)
                        }
                        Spacer()
                    }
                    Spacer()
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            
            Divider().background()
            
            ScrollView {
                ZStack {
                    VStack {
                        
                        Text("\(firstName)'s Latest Polls").font(.title3)
                        Divider().background().frame(width: 150)
                        ForEach(viewModel.polls) { poll in
                            PollView(poll: poll)
                                .padding(5)
                        }
                        Spacer()
                        
                    }
                }
            }
        }
        .background(Color.black)
        .ignoresSafeArea(.all, edges: [.leading, .trailing])
        .foregroundColor(.white)
        .onAppear {
            viewModel.fetchUserInfo()
        }
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id: "", username: "Test", fullName: "Test User", profileImageUrl: "", email: "test@email.com"))
            .environmentObject(AuthViewModel())
    }
}
