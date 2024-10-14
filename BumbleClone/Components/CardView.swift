//
//  CardView.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 14/10/2024.
//

import SwiftUI

struct CardView: View {
    
    var user: User = .mock
    private var shadow = Color.black.opacity(0.6)
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                
                headerCell
                .frame(height: 600)
            }
        }
        .scrollIndicators(.hidden)
        .cornerRadius(32)
    }
    
    private var headerCell: some View {
        ZStack(alignment: .bottomLeading) {
            profileImage
            VStack(alignment: .leading) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                BumbleHeartView()
                    .onTapGesture {
                        //
                    }
            }
            .padding(24)
            .foregroundStyle(.bumbleWhite)
            .font(.callout)
            .fontWeight(.medium)
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.1)
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
        }
    }
    
    private var profileImage: some View {
        ImageLoaderView(urlString: user.image)
        
    }
    
    private var sendCompliment: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(.bumbleYellow)
    }
}

#Preview {
    CardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
