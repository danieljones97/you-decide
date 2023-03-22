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
                    .font(.title)
            }
            
            //Page Contents
            Button {
                authViewModel.signOut()
            } label: {
                HStack {
                    Text("Sign Out")
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
                .padding(.vertical, 8)
                Spacer()
            }
            
            Spacer()
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
