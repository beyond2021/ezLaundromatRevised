//
//  EZLaundromatApp.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/9/24.
//

import SwiftUI
import Firebase

@main
struct EZLaundromatApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
