//
//  InputFields.swift
//  YouDecide
//
//  Created by Daniel Jones on 01/02/2023.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    var darkMode: Bool = false
    
    var body: some View {
        VStack {
            HStack {
              Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                        .foregroundColor(darkMode ? .black : .white)
                } else {
                    TextField(placeholderText, text: $text)
                        .foregroundColor(darkMode ? .white : .black)
                }
            }.padding(.bottom, 8)
            
            Divider()
                .background(darkMode ? Color.white : Color.gray)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope",
                         placeholderText: "Email",
                         text: .constant(""))
    }
}
