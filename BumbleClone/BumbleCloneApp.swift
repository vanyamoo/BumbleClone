//
//  BumbleCloneApp.swift
//  BumbleClone
//
//  Created by Vanya Mutafchieva on 14/10/2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct BumbleCloneApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                HomeView()
            }
        }
    }
}
