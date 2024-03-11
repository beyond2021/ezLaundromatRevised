//
//  ContentView.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/9/24.
//

import SwiftUI



struct ContentView: View {
    // Userdefaults
    @AppStorage("log_status") private var logStatus: Bool = false
    var body: some View {
//      Login()
    //EZMainPage()
        Group{
            if logStatus{
                //MainPage()
                EZMainPage()
            }
            else{
                Login()
            }
        }
    }
}

#Preview {
    ContentView()
}
