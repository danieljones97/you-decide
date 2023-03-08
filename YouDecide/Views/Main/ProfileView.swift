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
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            
            VStack {
                VStack {
                    
                    
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 72, height: 72)
                    
                    NavigationLink {
                        ProfilePhotoSelectorView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack {
                            Text("Select a new profile photo")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Text(user.fullName).font(.title)
                    Text("@\(user.username)").foregroundColor(.gray)
                    
                    
                }
                .padding(.top, 40)
                .frame(width: UIScreen.main.bounds.size.width)
                .overlay {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                viewModel.signOut()
                            } label: {
                                HStack {
                                    Text("Sign Out")
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
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
                                    Text("Back to Feed")
                                }
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
                            
                            Text("My Latest Polls").font(.title3)
                            Divider().background().frame(width: 150)
//                            PollView(username: "Username", userProfileImageUrl: "", dateCreated: "01-01-2020", poll: poll)
//                            PollView(username: "Username", userProfileImageUrl: "", dateCreated: "01-01-2020", poll: poll)
//                            PollView(username: "Username", userProfileImageUrl: "", dateCreated: "01-01-2020", poll: poll)
                            Spacer()
                            
                        }
                    }
                }
            }.background(Color.black).ignoresSafeArea(.all, edges: [.leading, .trailing]).foregroundColor(.white)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
