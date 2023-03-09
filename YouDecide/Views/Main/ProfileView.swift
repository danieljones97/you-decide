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
                
                KFImage(URL(string: viewModel.user.profileImageUrl))
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
                
                Text(viewModel.user.fullName).font(.title)
                Text("@\(viewModel.user.username)").foregroundColor(.gray)
                
            }
            .padding(.top, 40)
            .frame(width: UIScreen.main.bounds.size.width)
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            authViewModel.signOut()
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
                                Text("Back")
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
        }.background(Color.black).ignoresSafeArea(.all, edges: [.leading, .trailing]).foregroundColor(.white)
    }
    
}


//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//            .environmentObject(AuthViewModel())
//    }
//}
