//
//  ProfilePhotoSelectorView.swift
//  YouDecide
//
//  Created by Daniel Jones on 15/02/2023.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            AuthHeaderView(mainTitle: "Update Account", secondaryTitle: "Select a profile photo")
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                } else {
                    VStack {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .frame(width: 150, height: 150)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.top, 25)
                        Text("Select an image")
                            .padding(.top, 10)
                    }.foregroundColor(Color.black)
                }
            }.sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }.padding(.top, 50)

            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.black)
                        .clipShape(Capsule())
                        .padding()
                }
            }
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Cancel")
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(.gray)
        }
        .ignoresSafeArea()
        .background(Color.white)
        .preferredColorScheme(.light)
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
            .environmentObject(AuthViewModel())
    }
}
