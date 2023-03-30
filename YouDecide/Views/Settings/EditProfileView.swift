//
//  EditProfileView.swift
//  YouDecide
//
//  Created by Daniel Jones on 29/03/2023.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    
    @State private var fullName: String
    @State private var username: String
    @State private var email: String
    private var userId: String
    
    init?(user: User) {
        self.userId = user.id!
        _fullName = State(initialValue: user.fullName)
        _username = State(initialValue: user.username)
        _email = State(initialValue: user.email)
    }

    let service = UserService()
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                }
                
                Spacer()
            }
            .padding()
            
            
            HStack {
                Text("Full Name")
                    .padding()
                Spacer()
            }
            CustomInputField(imageName: "person", placeholderText: "", text: $fullName, darkMode: true)
                .padding(.horizontal)
            
            HStack {
                Text("Username")
                    .padding()
                Spacer()
            }
            CustomInputField(imageName: "at", placeholderText: "", text: $username, darkMode: true)
                .padding(.horizontal)
            
            HStack {
                Text("Email")
                    .padding()
                Spacer()
            }
            CustomInputField(imageName: "person", placeholderText: "", text: $email, darkMode: true)
                .disabled(true)
                .padding(.horizontal)
            
            Spacer()
            
            Button {
                save()
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(.white)
                    .clipShape(Capsule())
                    .padding()
            }
        }
        .alert("Error", isPresented: $showError, actions: {
            Button(role: .cancel) { } label: {
                Text("Dismiss")
            }
        }, message: {
            Text("Unable to save user, please try again later")
        })
        .background(Color.black)
        .foregroundColor(.white)
        .preferredColorScheme(.dark)
        
    }
    
    func save() {
        service.updateUser(id: userId, username: username, email: email, fullName: fullName) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
                showError = true
            }
        }
    }
    
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User(username: "username", fullName: "fullname", profileImageUrl: "", email: "email"))
    }
}
