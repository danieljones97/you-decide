//
//  Settings.swift
//  YouDecide
//
//  Created by Daniel Jones on 22/03/2023.
//

import SwiftUI
import UserNotifications

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
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "bell")
                        Text("Notifications")
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }
                .padding(.horizontal)
                
                
                Button {
                    let content = UNMutableNotificationContent()
                    content.title = "YouDecide"
                    content.subtitle = "This is a test notification"
                    content.sound = UNNotificationSound.default
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                } label: {
                    HStack {
                        Image(systemName: "bell.badge.fill")
                        Text("Send Test Notification")
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }
                .padding(.horizontal)
                
                
                Button {
                    authViewModel.signOut()
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out")
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                
                

                
                
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
