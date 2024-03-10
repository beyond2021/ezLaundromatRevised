//
//  EZProducTypeView.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI

struct EZProductDetailView: View {
    var product: EZProduct
    
    // For Matched Geometry Effect...
    var animation: Namespace.ID
    
    // Shared Data Model...
    @EnvironmentObject var sharedData: EZSharedDataModel
    
    @EnvironmentObject var homeData: EZHomeViewModel
    //
    @State private var alert3: AlertConfig = .init(disableOutsideTap: false, slideEdge: .trailing)
    
    var body: some View {
        
        VStack{
            
            // Title Bar and Product Image...
            VStack{
                
                // Title Bar...
                HStack{
                    
                    Button {
                        // Closing View...
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }


                }
                .padding()
                
                // Product Image...
                // Adding Matched Geometry Effect...
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            // product Details...
            ScrollView(.vertical, showsIndicators: false) {
                
                // Product Data...
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                        .foregroundStyle(.white)
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.black)
                    
                    Text("Get 1 free wash when you checkout 50")
                        .font(.custom(customFont, size: 16).bold())
                        .foregroundStyle(.white)
                       // .padding(.top)
                    
                    Text(product.description)
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.black)
                    
                    Button {
                        
                    } label: {
                        
                        // Since we need image at right...
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color.white)
                    }
                   // Spacer()
                    Spacer(minLength: 60)

                    HStack{
                        
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.vertical,20)
                    //.padding(.bottom, 40)
                    
                    
                    // Add button...
                    Button {
                        alert3.present()
                        addToCart()
                       // alert3.present()
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add") to basket")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            //.padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                            
//                                Color("Purple")
                                Color.appBlue
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }
                    .buttonStyle(ColoredButtonStyle(color: Color.appBlue))

                }
                
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
//                Color.white
                LinearGradient(colors: [Color.appBlue, .white], startPoint: .top, endPoint: .bottom)
                // Corner Radius for only top side....
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .alert(alertConfig: $alert3) {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(colors: [Color.appBlue, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 150, height: 150)
                .overlay(content: {
                    Text("\(product.title) is added to your Cart.")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(15)
                        .multilineTextAlignment(.center)
                })
                .onTapGesture {
                    alert3.dismiss()
                }
        }
    }
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.likedProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.cartProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.cartProducts.append(product)
        }
    }
}

struct EZProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample Product for Building Preview....
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        
        EZMainPage()
    }
}
struct ColoredButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 50)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}

