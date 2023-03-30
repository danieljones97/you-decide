//
//  Settings.swift
//  YouDecide
//
//  Created by Daniel Jones on 22/03/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            //Nav Bar
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
                Text("Settings")
                    .foregroundColor(Color.white)
                    .font(.title2)
            }
            .padding(.horizontal)
            
            //Button List
            
            VStack {
                NavigationLink {
                    if let user = authViewModel.currentUser {
                        NavigationLazyView(EditProfileView(user: user))
                            .navigationBarHidden(true)
                    }
                } label: {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Edit Profile")
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }.padding(.horizontal)
                
                
                NavigationLink {
                    //Add view here
                } label: {
                    HStack {
                        Image(systemName: "figure.wave.circle")
                        Text("Accessibility")
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }.padding(.horizontal)
                
                
                NavigationLink {
                    //Add view here
                } label: {
                    HStack {
                        Image(systemName: "list.clipboard")
                        Text("Terms & Conditions")
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }.padding(.horizontal)
                
                
                NavigationLink {
                    //Add view here
                } label: {
                    HStack {
                        Image(systemName: "hand.raised")
                        Text("Privacy Policy")
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }.padding(.horizontal)
                
                
                Button {
                    authViewModel.signOut()
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out")
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }
                .padding()
                
                
                Spacer()
                
            }
            .padding(.top, 20)
        }
        .padding(.leading, 3)
        .ignoresSafeArea(.all, edges: [.leading, .trailing])
        .background(Color.black)
        .foregroundColor(Color.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
