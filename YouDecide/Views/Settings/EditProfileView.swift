//
//  EditProfileView.swift
//  YouDecide
//
//  Created by Daniel Jones on 29/03/2023.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self.viewModel = EditProfileViewModel(user: user)
    }
    
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
            CustomInputField(imageName: "person", placeholderText: "", text: $viewModel.fullName, darkMode: true)
                .padding(.horizontal)
            
            HStack {
                Text("Username")
                    .padding()
                Spacer()
            }
            CustomInputField(imageName: "at", placeholderText: "", text: $viewModel.username, darkMode: true)
                .padding(.horizontal)
            
            HStack {
                Text("Email")
                    .padding()
                Spacer()
            }
            CustomInputField(imageName: "person", placeholderText: "", text: $viewModel.email, darkMode: true)
                .disabled(true)
                .padding(.horizontal)
            
            Spacer()
            
            Button {
                viewModel.save()
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
        .alert("Error", isPresented: $viewModel.showError, actions: {
            Button(role: .cancel) { } label: {
                Text("Dismiss")
            }
        }, message: {
            Text("Unable to save user, please try again later")
        })
        .onReceive(viewModel.$didUpdateUser) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .background(Color.black)
        .foregroundColor(.white)
        .preferredColorScheme(.dark)
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User(username: "username", fullName: "fullname", profileImageUrl: "", email: "email"))
    }
}
