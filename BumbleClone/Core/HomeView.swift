//
//  HomeView.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 14/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 12) {
                header
                
                FilterView(options: filters, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom)
                
                filterSection
                
                Spacer()
            }
            //.padding()
        }
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
    private var filterSection: some View {
        Circle()
    }
}

#Preview {
    HomeView()
}
