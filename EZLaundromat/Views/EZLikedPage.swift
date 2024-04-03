//
//  EZLikedPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI
import SwiftData

struct EZLikedPage: View {
    @EnvironmentObject var sharedData: EZSharedDataModel
    // Delete Option...
    @State var showDeleteOption: Bool = false
    // Persistence
    @Query private var items: [EZProduct]
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack{
                        Text("Favorites")
                            .font(.custom(customFont, size: 28).bold())
                            .foregroundStyle(.white)
                        Spacer()
                        Button {
                            withAnimation{
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    // checking if liked products are empty...
                    if sharedData.likedProducts.isEmpty{
                        // IF LIKE ARRAY IS EMPTY
                        Group{
                            Image("NoLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top,35)
                            Text("No favorites yet")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            Text("Hit the Like button on each product page to save favorite ones.")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top,10)
                                .multilineTextAlignment(.center)
                        }
                    }
                    else{
                        // SHOW WHATS IN LIKES ARRAY
                        // Displaying Products...
                        VStack(spacing: 15){
                            // For Designing...
                            ForEach(sharedData.likedProducts){product in
                                
                                HStack(spacing: 0){
                                    
                                    if showDeleteOption{
                                        
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                        
                                    }
                                    
                                    CardView(product: product)
                                }
                                
                            }
                            
                            
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [Color.appBlue, Color.white], startPoint: .top, endPoint: .bottom)
                
                //                Color("HomeBG")
                    .ignoresSafeArea()
            )
            
        }
        

 

    }
    
    @ViewBuilder
    func CardView(product: EZProduct)->some View{
        
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.appBlue)
                Text("Type: \(product.type)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
    
    func deleteProduct(product: EZProduct){
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                // removing...
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct EZLikedPage_Previews: PreviewProvider {
    static var previews: some View {
        EZLikedPage()
            .environmentObject(EZSharedDataModel())
    }
}

