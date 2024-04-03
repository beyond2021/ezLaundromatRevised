//
//  EZHome.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI

struct EZHome: View {
    @State private var overText = false
    var animation: Namespace.ID
    // Shared Data...
    @EnvironmentObject var sharedData: EZSharedDataModel
    @Namespace var newAnimation
    
    @StateObject var homeData: EZHomeViewModel = EZHomeViewModel()
    @State private var activeIntro: PageIntro = pageIntros[0]
    
    var body: some View {
//        GeometryReader {
//            let size = $0.size
//            IntroView(intro: $activeIntro, size: size) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15){
                        
                        // Search Bar...
                        
                        ZStack{
                            
                            if homeData.searchActivated{
                                SearchBar()
                            }
                            else{
                                SearchBar()
                                    .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                            }
                        }
                        .frame(width: getRect().width / 1.6)
                        .padding(.horizontal,25)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                homeData.searchActivated = true
                            }
                        }
                        
                        Text("Ezlaundromat & Dry Cleaning\nServices")
                        //.multilineTextAlignment(.center)
                            .font(.custom(customFont, size: 28).bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.top)
                            .padding(.horizontal,25)
                        
                        // Products Tab....
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: 18){
                                
                                ForEach(EZProductType.allCases,id: \.self){type in
                                    
                                    // Product Type View...
                                    ProductTypeView(type: type)
                                }
                            }
                            .padding(.horizontal,25)
                        }
                        .padding(.top,28)
                        
                        // Products Page...
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: 25){
                                ForEach(homeData.filteredProducts){product in
                                    ProductCardView(product: product)
                                        .frame(maxWidth: 200)
                                }
                            }
                            .padding(.horizontal,25)
                            .padding(.bottom)
                            .padding(.top,80)
                        }
                        .padding(.top,30)
                        HStack {
                            Button {
                                homeData.showAboutUs.toggle()
                            } label: {
                                Label {
                                    Image(systemName: "arrow.left")
                                } icon: {
                                    Text("ABOUT US")
                                        .font(.custom(customFont, size: 14))
                                }
//                                .padding()
//                                .foregroundStyle(overText ? Color.white : Color.appBlue)
//                                .background(overText ? Color.appBlue: Color.clear)
//                                .cornerRadius(6.0)
                                .modifier(EZButton())
                                
 
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.leading)
                            .padding(.top,10)
                            
                            Spacer()
                            
                            
                            Button {
                                homeData.showMoreProductsOnType.toggle()
                            } label: {
                                
                                // Since we need image ar right...
                                Label {
                                    Image(systemName: "arrow.right")
                                } icon: {
                                    Text("PRICING")
                                        .font(.custom(customFont, size: 14))
                                }
                                .modifier(EZButton())
//                                .padding()
//                                .foregroundColor(.appBlue)
//                                .background(Color.clear)
//                                
//                                .cornerRadius(6.0)
                              
                            }
                            .frame(maxWidth: .infinity,alignment: .trailing)
                            .padding(.trailing)
                            .padding(.top,10)
                        }
                        
                    }
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                //.background(Color("HomeBG"))
                .background( LinearGradient(colors: [Color.appBlue, Color.white], startPoint: .top, endPoint: .bottom))
                // Updating data whenever tab changes...
                .onChange(of: homeData.ezProductType, initial: false) { oldValue, newValue in
                    homeData.filterProductByType()
                }
                // Preview Issue...
                .sheet(isPresented: $homeData.showMoreProductsOnType) {
                    
                } content: {
                    //            MoreProductsView()
                    PriceList()
                }
                
                .sheet(isPresented: $homeData.showAboutUs) {
                    
                } content: {
                    AboutUS()
                }
                // Displaying Search View....
                .overlay(
                    
                    ZStack{
                        
                        if homeData.searchActivated{
                            EZSearchView(animation: animation)
                                .environmentObject(homeData)
                        }
                    }
                )
            }
            //
//        }
//    }
 
            
    // Since we're adding matched geometry effect...
    // avoiding code replication...
    @ViewBuilder
    func SearchBar()->some View{
        
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            // Since we need a separate view for search bar....
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(
        
            Capsule()
                .strokeBorder(Color.gray,lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: EZProduct)->some View{
        
        VStack(spacing: 5){
            
            // Adding Matched Geometry Effect...
            ZStack{
                
                if sharedData.showDetailProduct{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(5)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                        .cornerRadius(5)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
        // Moving image to top to look like its fixed at half top...
            .offset(y: -80)
            .padding(.bottom,-80)
            
            Text(product.title)
//                .font(.custom(secondaryFont, size: 25))
                .font(.title2)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
//                .foregroundStyle(.white)
              //  .padding(.top)
            
            Text(product.subtitle)
//                .font(.custom(secondaryFont, size: 18))
                .font(.caption)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.white)
            
            Text("$\(product.price)")
//                .font(.custom(secondaryFont, size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            LinearGradient(colors: [Color.white, Color.appBlue], startPoint: .top, endPoint: .bottom)
//            Color.white
                .cornerRadius(15)
        )
        // Showing Product detail when tapped...
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func ProductTypeView(type: EZProductType)->some View{
        
        Button {
            // Updating Current Type...
            withAnimation{
                homeData.ezProductType = type
            }
        } label: {
            
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
            // Changing Color based on Current product Type...
                .foregroundColor(homeData.ezProductType == type ? Color.white : Color.black)
                .padding(.bottom,10)
            // Adding Indicator at bottom...
                .overlay(
                
                    // Adding Matched Geometry Effect...
                    ZStack{
                        if homeData.ezProductType == type{
                            Capsule()
                                .fill(.white)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }
                        else{
                            
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .padding(.horizontal,-5)
                    
                    ,alignment: .bottom
                )
        }
    }
}

struct EZHome_Previews: PreviewProvider {
    static var previews: some View {
        EZMainPage()
    }
}

/// Intro View
struct IntroView<ActionView: View>: View {
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    
    /// Animation Properties
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    var body: some View {
        VStack {
            /// Image View
            GeometryReader {
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
            }
            /// Moving Up
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
            /// Tile & Action's
            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)
                
                Text(intro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                
                Text(intro.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                
                if !intro.displaysAction {
                    Group {
                        Spacer(minLength: 25)
                        
                        /// Custom Indicator View
                        CustomIndicatorView(totalPages: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            changeIntro()
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background {
                                    Capsule()
                                        .fill(.black)
                                }
                        }
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    /// Action View
                    Login()
               
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            /// Moving Down
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
        }
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        /// Back Button
        .overlay(alignment: .topLeading) {
            /// Hiding it for Very First Page, Since there is no previous page present
            if intro != pageIntros.first {
                Button {
                    changeIntro(true)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                }
                .padding(10)
                /// Animating Back Button
                /// Comes From Top When Active
                .offset(y: showView ? 0 : -200)
                /// Hides by Going back to Top When In Active
                .offset(y: hideWholeView ? -200 : 0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
    }
    
    /// Updating Page Intro's
    func changeIntro(_ isPrevious: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            /// Updating Page
            if let index = pageIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != pageIntros.count - 1) {
                intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
            } else {
                intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            /// Re-Animating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter { !$0.displaysAction }
    }
    
    
}

