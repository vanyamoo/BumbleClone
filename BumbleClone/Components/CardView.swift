//
//  CardView.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 14/10/2024.
//

import SwiftUI
import SwiftfulUI

struct CardView: View {
    
    var user: User = .mock
    var onSuperlikePressed: (() -> Void)?
    var onXMarkPressed: (() -> Void)?
    var onCheckMarkPressed: (() -> Void)?
    var onSendAComplimentPressed: (() -> Void)?
    var onHideAndreportPressed: (() -> Void)?
    
    @State private var cardFrame: CGRect = .zero
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                headerCell
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                    .padding(24)
                
                myInterestsSection
                    .padding(24)
                
                imagesSection
                
                locationSection
                    .padding(24)
                
                buttonsSection
                    .padding(32)
                
                footerSection
                    .padding(.vertical, 60)
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(
            superlikeButton
                .padding(24)
            , alignment: .bottomTrailing
        )
        .cornerRadius(32)
        .readingFrame { frame in // adds a GeometryReader on the background of the ScrollView
            cardFrame = frame
        }
    }
    
    private var superlikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 50))
            .overlay(
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.system(size: 30, weight: .medium))
            )
            .onTapGesture {
                onSuperlikePressed?()
            }
            
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
            .background(gradient)
        }
    }
    
    private var gradient: some View {
        LinearGradient(
            colors: [
                .bumbleBlack.opacity(0.6),
                .bumbleBlack.opacity(0.6),
                .bumbleBlack.opacity(0.1)
            ],
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    private var profileImage: some View {
        ImageLoaderView(urlString: user.image)
        
    }
    
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(.bumbleGray)
    }
    
    private func bodyText(_ text: String) -> some View {
        Text(text)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleBlack)
    }
    
    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle("About me")
            bodyText(user.aboutMe)
            sendCompliment
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle("My basics")
                InterestPillGridView(interests: user.basicInfo)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle("My interests")
                InterestPillGridView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var imagesSection: some View {
        ForEach(user.images, id: \.self) { image in
            ImageLoaderView(urlString: image)
                .frame(height: cardFrame.height)
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                sectionTitle(user.firstName + "'s location")
            }
            bodyText("\(user.distance) miles away")
            InfoPillView(info: "Lives in \(user.city), \(user.state)", iconName: nil, emoji: "\(user.country)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var buttonsSection: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.title)
                .padding()
                .background(.bumbleYellow)
                .clipShape(Circle())
                .onTapGesture {
                    onXMarkPressed?()
                }
            Spacer(minLength: 0)
            Image(systemName: "checkmark")
                .font(.title)
                .padding()
                .background(.bumbleYellow)
                .clipShape(Circle())
                .onTapGesture {
                    onCheckMarkPressed?()
                }
        }
    }
    
    private var footerSection: some View {
        Text("Hide and Report")
            .font(.headline)
            .foregroundStyle(.bumbleGray)
            .padding()
            .onTapGesture {
                onHideAndreportPressed?()
            }
    }
    
    private var sendCompliment: some View {
        HStack(spacing: 0) {
            BumbleHeartView()
            Text("Send a Compliment")
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.trailing, 4)
                .onTapGesture {
                    onSendAComplimentPressed?()
                }
                
        }
        .padding(.horizontal, 12)
        .background(.bumbleYellow)
        .clipShape(Capsule())
    }
}

#Preview {
    CardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
