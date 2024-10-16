//
//  ChatsView.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 16/10/2024.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var allUsers: [User] = []
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack {
                header
            
                matchQueueSection
                
                chatsSection
            }
            //.frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    @ViewBuilder
    private var matchQueueSection: some View {
        SectionHeader(title: "Match Queue", subtitle: String(allUsers.count))
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(allUsers) { user in
                    ProfileImageCell(
                        imageName: user.image,
                        hasNewMessage: Bool.random()
                    )
                    .padding(4)
                }
            }
            
        }
        .scrollIndicators(.hidden)
        .frame(height: 100)
    }
    @ViewBuilder
    private var chatsSection: some View {
        SectionHeader(title: "Chats", subtitle: String(allUsers.count), filter: "Recent")
        
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(allUsers) { user in
                    BumbleChatPreviewCell(
                        imageName: user.image,
                        percentageRemaining: Double.random(in: 0...1),
                        hasNewMessage: Bool.random(),
                        userName: user.firstName,
                        isYourMove: Bool.random()
                    )
                    .padding(4)
                }
            }
        }
        .padding(.horizontal)
    }
    
    struct SectionHeader: View {
        
        var title: String
        var subtitle: String?
        var filter: String?
        
        var body: some View {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                
                if let subtitle {
                    Text("(" + subtitle + ")")
                        .foregroundStyle(.bumbleGray)
                }
                Spacer(minLength: 0)
                if filter != nil {
                    Image(systemName: "line.horizontal.3.decrease")
                        .font(.title2)
                        .fontWeight(.medium)
                }
            }
            .font(.title3)
            .padding(.horizontal)
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        
        Text(title)
            .font(.title2)
            .fontWeight(.medium)
    }
    private func sectionSubTitle(_ title: String) -> some View {
        Text(" (\(allUsers.count))")
            .font(.title2)
            .foregroundStyle(.bumbleGray)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Image(systemName: "line.horizontal.3")
                .onTapGesture {
                    //
                }
            Spacer()
            Image(systemName: "magnifyingglass")
                .onTapGesture {
                    //
                }
        }
        .font(.title)
        .fontWeight(.medium)
        .padding()
    }
    
    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ChatsView()
}
