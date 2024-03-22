//
//  OnBoardingPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 26/11/21.
//

import SwiftUI
import Lottie

// To Use the custom font on all pages..
//let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    // Showing Login Page...
    @State var showLoginPage: Bool = false
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Welcome\nto\nEZLaundromat")
                .font(.custom(customFont, size: 25))
            // Since we added all three fonts in Info.plist
            // We can call all of those fonts with any names...
                .fontWeight(.bold)
                .foregroundColor(.white)
            
//            Image("EZWashingMaching001")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding(.top, 60)
            GeometryReader { _ in
                if let bundle = Bundle.main.path(forResource: "washinmachine", ofType: "json") {
                    LottieView {
                        await LottieAnimation.loadedFrom(url: URL(filePath: bundle))
                    }
                    .playing(loopMode: .loop)
                }
            }
//            .padding(.top, -50)
            
//            Spacer()
            
            Button {
                withAnimation{
                    showLoginPage = true
                }
            } label: {
             
                Text("Get started")
                    .whiteEZButtonStyle()
//                    .font(.custom(customFont, size: 18))
//                    .fontWeight(.semibold)
//                    .padding(.vertical,18)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.white)
//                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
//                    .foregroundColor(Color.appBlue)
            }
            .padding(.horizontal,30)
            // Adding Some Adjustments only for larger displays...
            .offset(y: getRect().height < 750 ? 20 : 40)
            .padding(.bottom,40)
            
//            Spacer()
        }
        .padding()
        .padding(.top,getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
            Color(Color.appBlue)
        )
        .overlay(
        
            Group{
                if showLoginPage{
                    Login()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

// Extending View to get Screen Bounds..
//extension View{
//    func getRect()->CGRect{
//        return UIScreen.main.bounds
//    }
//}
