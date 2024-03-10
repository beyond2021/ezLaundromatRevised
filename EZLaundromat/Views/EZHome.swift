//
//  EZHome.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI

struct EZHome: View {
    var animation: Namespace.ID
    // Shared Data...
    @EnvironmentObject var sharedData: EZSharedDataModel
    
    @StateObject var homeData: EZHomeViewModel = EZHomeViewModel()
    
    var body: some View {
        
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
                            
                            // Product Card View...
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top,80)
                }
                .padding(.top,30)
                
                // See More Button...
                // This button will show all products on the current product type..
                // since here were showing only 4...
                
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    
                    // Since we need image ar right...
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color.appBlue)
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
                .padding(.top,10)

            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        //.background(Color("HomeBG"))
        .background( LinearGradient(colors: [Color.appBlue, Color.white], startPoint: .top, endPoint: .bottom))
        // Updating data whenever tab changes...
        .onChange(of: homeData.ezProductType) { newValue in
            homeData.filterProductByType()
        }
        // Preview Issue...
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
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
                .font(.custom(secondaryFont, size: 25))
                .fontWeight(.bold)
                .foregroundStyle(.white)
              //  .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(secondaryFont, size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color.appBlue)
            
            Text(product.price)
                .font(.custom(secondaryFont, size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            LinearGradient(colors: [Color.white, Color.appBlue], startPoint: .top, endPoint: .bottom)
                .cornerRadius(25)
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