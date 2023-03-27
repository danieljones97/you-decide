//
//  RegistrationView.swift
//  YouDecide
//
//  Created by Daniel Jones on 01/02/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            
//            NavigationLink(destination: ProfilePhotoSelectorView(),
//                           isActive: $viewModel.didAuthenticateUser,
//                           label: { })
            
            AuthHeaderView(mainTitle: "Welcome.", secondaryTitle: "Create an account.")
            
            VStack(spacing: 30) {
                CustomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                
                CustomInputField(imageName: "person", placeholderText: "Username", text: $username)
                
                CustomInputField(imageName: "person", placeholderText: "Full Name", text: $fullname)
                
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
            }.padding(30)
            
            Button {
                viewModel.register(withEmail: email, password: password, fullName: fullname, username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.black)
                    .clipShape(Capsule())
                    .padding()
            }
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.caption)
                    Text("Sign In")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(.gray)

            
        }
        .ignoresSafeArea()
        .background(Color.white)
        .preferredColorScheme(.light)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
