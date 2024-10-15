//
//  HomeView.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 14/10/2024.
//

import SwiftUI
import SwiftfulUI

struct HomeView: View {
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var cardOffsets: [Int:Bool] = [:] // UserId : (Direction is right == TRUE)
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 12) {
                header
                
                FilterView(options: filters, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom)
                
//                CardView()
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            
                            let isPrevious = (selectedIndex - 1 == index)
                            let isCurrent = (selectedIndex == index)
                            let isNext = (selectedIndex + 1 == index)
                            if isPrevious || isCurrent || isNext {
                                let offsetValue = cardOffsets[user.id]
                                
                                userProfileCell(index: index)
                                    .zIndex(Double(allUsers.count - index)) // stacks teh cards in reverse order
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxHeight: .infinity)
                .animation(.smooth, value: cardOffsets)
            }
            .padding()
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        
        selectedIndex += 1
    }
    
    private var header: some View {
        HStack(spacing: 0) {
                headerLeft
                    .frame(maxWidth: .infinity, alignment: .leading)
                logo
                    .frame(maxWidth: .infinity, alignment: .center)
                headerRight
                    .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    private func userProfileCell(index: Int) -> some View {
        Rectangle()
            .fill(index == 0 ? .red : .blue)
            .overlay(Text("\(index)"))
            .withDragGesture(
                .horizontal,
//                                        minimumDistance: <#T##CGFloat#>,
                resets: true,
                rotationMultiplier: 1.05,
//                                        scaleMultiplier: 0.9,
                onChanged: { dragOffset in
                    //offset = dragOffset.width
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -50 {
                        userDidSelect(index: index, isLike: false)
                    } else if dragOffset.width > 50 {
                        userDidSelect(index: index, isLike: true)
                    }
                }
            )
    }
    
    private var headerLeft: some View {
        HStack(spacing: 0) {
            Image(systemName: "line.horizontal.3")
                .padding()
                .contentShape(.interaction, .rect)
                .onTapGesture {
                    //
                }
            
            Image(systemName: "arrow.uturn.left")
                .padding()
                .contentShape(.interaction, .rect)
                .onTapGesture {
                    //
                }
        }
    }
    private var logo: some View {
        Text("bumble")
            .font(.title)
            .foregroundStyle(.bumbleYellow)
    }
    
    private var headerRight: some View {
        Image(systemName: "slider.horizontal.3")
            .padding()
            .contentShape(.interaction, .rect)
            .onTapGesture {
                //
            }
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
    HomeView()
}
