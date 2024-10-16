//
//  BumbleChatPreviewCell.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 16/10/2024.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    
    var imageName = Constants.randomImage
    var percentageRemaining = Double.random(in: 0...1)
    var hasNewMessage = true
    
    var userName: String = "Vanya"
    var lastChatMessage: String? = "Let's meet at Starbucks on Saturday at 4pm. I'll be wearing a black biker jacket and jeans."
    var isYourMove: Bool = true
    
    var body: some View {
        HStack(spacing: 12) {
            ProfileImageCell(imageName: imageName, percentageRemaining: percentageRemaining, hasNewMessage: hasNewMessage)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 0) {
                    Text(userName)
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    if isYourMove {
                        Text("YOUR MOVE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(4)
                            .background(.bumbleYellow)
                            .cornerRadius(.infinity)
                    }
                }
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .lineLimit(1)
                        .foregroundStyle(.bumbleGray)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack {
        BumbleChatPreviewCell(isYourMove: false)
        BumbleChatPreviewCell(hasNewMessage: false, userName: "Terry")
        BumbleChatPreviewCell(userName: "Angelina", isYourMove: false)
        BumbleChatPreviewCell(hasNewMessage: false, userName: "Kate")
        BumbleChatPreviewCell(userName: "Francesco",isYourMove: false)
    }
    .padding()
}
