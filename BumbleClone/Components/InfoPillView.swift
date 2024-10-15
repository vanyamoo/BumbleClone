//
//  InfoPillView.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 15/10/2024.
//

import SwiftUI

struct InfoPillView: View {
    
    var info: String = "Graduate degree"
    var iconName: String? = "heart.fill"
    var emoji: String? = "🤙"
    
    var body: some View {
        HStack(spacing: 4) {
            icon
            Text(info)
                .font(.callout)
                .fontWeight(.medium)
                .frame(maxHeight: 24)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightYellow)
        .clipShape(Capsule())
    }
    
    @ViewBuilder
    private var icon: some View {
        if let iconName {
            Image(systemName: iconName)
        } else if let emoji {
            Text(emoji)
        }
    }
}



#Preview {
    
    var basicInfo: [User.UserInfo] {
        [
            User.UserInfo(info: "176", iconName: "ruler", emoji: nil, iconType: "systemImage"),
            User.UserInfo(info: "Graduate Degree", iconName: "graduationcap", emoji: nil, iconType: "systemImage"),
            User.UserInfo(info: "Socially", iconName: "wineglass", emoji: nil, iconType: "systemImage"),
            User.UserInfo(info: "Virgo", iconName: "moon.stars.fill", emoji: nil, iconType: "systemImage")
        ]
    }
    
    var interests: [User.UserInfo] {
        [
            User.UserInfo(info: "Running", iconName: nil, emoji: "👟", iconType: "emoji"),
            User.UserInfo(info: "Gym", iconName: nil, emoji: "🏋️‍♂️", iconType: "emoji"),
            User.UserInfo(info: "Music", iconName: nil, emoji: "🎧", iconType: "emoji"),
            User.UserInfo(info: "Cooking", iconName: nil, emoji: "🥘", iconType: "emoji")
        ]
    }
    
    ZStack {
        Color.bumbleBackgroundYellow
        
        VStack(alignment: .leading) {
            Text("My Basics")
            LazyVGrid(columns: [GridItem()], alignment: .leading , spacing: 4) {
                
                ForEach(basicInfo, id: \.self) { info in
                    InfoPillView(info: info.info, iconName: info.iconName, emoji: info.emoji)
                }
            }
            
            Text("My Interests")
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], alignment: .leading , spacing: 4) {
                
                ForEach(interests, id: \.self) { interest in
                    InfoPillView(info: interest.info, iconName: interest.iconName, emoji: interest.emoji)
                }
            }
        }
        .padding()
        
    }
    .padding()
}
