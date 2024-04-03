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
    @State private var activeIntro: PageIntro = pageIntros[0]
    var body: some View {
        Group{
            if logStatus{
                //MainPage()
                EZMainPage()
                   
            }
            else{
               OnBoardingPage()
                
            }
        }
    }
}

#Preview {
    ContentView()
}
