//
//  EZMainPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI
import Firebase

struct EZMainPage: View {
    //
    @AppStorage("showNewDetail") private var showNewDetail: Bool = false
    
    // Current Tab...
    @State var currentTab: Tab = .Home
    
    
    @StateObject var sharedData: EZSharedDataModel = EZSharedDataModel()
    
    // Animation Namespace...
    @Namespace var animation
    
    // Hiding Tab Bar...
    init(){
        UITabBar.appearance().isHidden = true
        
    }
    var body: some View {
        
        VStack(spacing: 0){
            
            // Tab View...
            TabView(selection: $currentTab) {
                EZHome(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                EZLikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                
                EZProfilePage()
                    .tag(Tab.Profile)
                
//                EZCartPage()
//                    .environmentObject(sharedData)
//                    .tag(Tab.Cart)
                Cart()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
            }
            
            // Custom Tab Bar...
            HStack(spacing: 0){
                ForEach(Tab.allCases,id: \.self){tab in
                    
                    Button {
                        // updating tab...
                        currentTab = tab
                    } label: {
                     
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        // Applying little shadow at bg...
                            .background(
                                showNewDetail ? Color.appPurple
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    // blurring...
                                    .blur(radius: 5)
                                    // Making little big...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                                
                                
                                
                                : Color.appBlue
//                                    Color.appBlue
                                    //                                Color.appBlue
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    // blurring...
                                    .blur(radius: 5)
                                    // Making little big...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                                
                                
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.appPurple : Color.black.opacity(0.3))
                            
                    }
                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom,10)
            
        }
        .background(Color("HomeBG").ignoresSafeArea())
//        .background(Color.appLightBlue.ignoresSafeArea())
        .overlay(
        
            ZStack{
                // Detail Page...
                if let product = sharedData.detailProduct,sharedData.showDetailProduct{
//                   EZDetail(product: product, animation: animation)
                    if showNewDetail {
                        AnimationDetailView(product: product, animation: animation, tabSelection: $currentTab)
                            .environmentObject(sharedData)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                    } else {
                        EZProductDetailView(product: product, animation: animation)
                            .environmentObject(sharedData)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                        
                    }
                   
                    
//                    EZProductDetailView(product: product, animation: animation)
//                        .environmentObject(sharedData)
                    // adding transitions...
                        
                }
            }
        )
    }
//    func getMainAppTint() -> Color {
//        if currentTab == tab && showNewDetail == true {
//            Color.appBlue : Color.black.opacity(0.3)
//        }
//    }
}

struct EZMainPage_Previews: PreviewProvider {
    static var previews: some View {
        EZMainPage()
    }
}

// Making Case Iteratable...
// Tab Cases...
enum Tab: String,CaseIterable{
    
    // Raw Value must be image Name in asset..
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}

