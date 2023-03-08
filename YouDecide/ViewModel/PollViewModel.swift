//
//  PollViewModel.swift
//  YouDecide
//
//  Created by Daniel Jones on 08/03/2023.
//

import Foundation

class PollViewModel: ObservableObject {
    @Published var poll: Poll
    
    init(poll: Poll) {
        self.poll = poll
    }
    
}
