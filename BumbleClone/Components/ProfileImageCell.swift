//
//  ProfileImageCell.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 16/10/2024.
//

import SwiftUI

struct ProfileImageCell: View {
    
    var imageName = Constants.randomImage
    var percentageRemaining = Double.random(in: 0...1)
    var hasNewMessage = true
    
    var body: some View {
        
        ZStack {
            baseCircle
            
            trimmedCircle
            
            userProfileImage
            
            newMessageIndicator
        }
        .frame(width: Constants.BaseCircle.size, height: Constants.BaseCircle.size)
        
    }
    
    private var baseCircle: some View {
        Circle()
            .stroke(.bumbleGray, lineWidth: Constants.BaseCircle.lineWidth - 1)
    }
    
    private var trimmedCircle: some View {
        Circle()
            .trim(from: 0, to: percentageRemaining)
            .rotation(Constants.TrimmedCircle.rotation)
            .stroke(.bumbleYellow, lineWidth: Constants.BaseCircle.lineWidth)
            .scaleEffect(x: -1, y: 1, anchor: .center) // mirror
    }
    
    private var userProfileImage: some View {
        ImageLoaderView(urlString: imageName)
            .clipShape(Circle())
            .scaleEffect(Constants.UserImage.scaleFactor)
    }
    
    private var newMessageIndicator: some View {
        ZStack {
            if hasNewMessage {
                Circle()
                    .scaleEffect(Constants.NewMessageIndicator.scaleFactor * 1.3)
                    .foregroundStyle(.bumbleWhite)
                Circle()
                    .scaleEffect(Constants.NewMessageIndicator.scaleFactor)
            }
        }
        .foregroundStyle(.bumbleYellow)
        .offset(Constants.NewMessageIndicator.offset)
    }
}

extension Constants {
    struct BaseCircle {
        static let lineWidth: CGFloat = 4
        static let size: CGFloat = 90
    }
    
    struct TrimmedCircle {
        static let rotation: Angle = Angle(degrees: 270)
    }
    
    struct UserImage {
        static let scaleFactor: CGFloat = 0.88
    }
    
    struct NewMessageIndicator {
        static let scaleFactor: CGFloat = 0.25
        static let offset: CGSize = CGSize(width: Constants.BaseCircle.size / 3, height: Constants.BaseCircle.size / 3)
    }

}

#Preview {
    VStack {
        ProfileImageCell()
        ProfileImageCell(percentageRemaining: 1)
        ProfileImageCell(percentageRemaining: 0)
        ProfileImageCell(hasNewMessage: false)
    }
   
}
