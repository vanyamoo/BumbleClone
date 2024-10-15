//
//  InterestPillGridView.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 15/10/2024.
//

import SwiftUI
import SwiftfulUI

struct InterestPillGridView: View {
    
    var interests: [User.UserInfo] = User.mock.interests
    
    var body: some View {
        ZStack {
            NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8, items: interests) { interest in
                if let interest {
                    InfoPillView(info: interest.info, iconName: interest.iconName, emoji: interest.emoji)
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    InterestPillGridView()
}
