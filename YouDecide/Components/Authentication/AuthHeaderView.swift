//
//  AuthenticationHeader.swift
//  YouDecide
//
//  Created by Daniel Jones on 02/02/2023.
//

import SwiftUI

struct AuthHeaderView: View {
    let mainTitle: String
    let secondaryTitle: String
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack { Spacer() }
            
            Text(mainTitle)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(secondaryTitle)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(.black)
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(mainTitle: "Main", secondaryTitle: "Secondary")
    }
}
