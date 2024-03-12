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
    //
    @State private var showDescription: Bool = false
    @State private var showCartAnimation: Bool = false
    
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
                VStack( spacing: 5) {
                    
                    Text(product.title)
//                        .font(.custom(customFont, size: 30).bold())
                        .font(.title)
                        .fontWeight(.bold)
//                        .foregroundStyle(.white)
                    
                    Text(product.subtitle)
                        .font(.title3)
                        .fontWeight(.bold)
//                        .foregroundColor(.gray)
                    
                    Text("427 Anderson Avenue, Fairview NJ 07022")
                        .font(.custom(customFont, size: 12).bold())
                        .foregroundStyle(.white)
                    
                    Text("+1 (201) 366-4766")
                        .font(.custom(customFont, size: 16).bold())
                        .foregroundStyle(.white)
                       // .padding(.top)
                    
                    Text("tmitchell@ezlaundromat.net")
                        .font(.custom(customFont, size: 16).bold())
                        .accentColor(.red)
                        .foregroundStyle(.white)
                       // .padding(.top)
                    Text(.init("[Website](https://ezlaundromat.net//)"))
                        .accentColor(.red)
                    
                    
                    Text(product.description)
                        .font(.custom(customFont, size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Button {
                        showDescription = true
                    } label: {
                        
                        // Since we need image at right...
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
//                        .font(.custom(customFont, size: 15).bold())
                        .font(.callout.bold())
                        .tint(.black)
//                        .foregroundColor(Color.white)
                        .padding(.top)
                    }
                   // Spacer()
                    Spacer(minLength: 20)

                    HStack{
                        
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                        Spacer()
                        
                        Text("$\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundStyle(Color.appBlue)
                    }
                    .padding(.vertical,20)
                   // .padding(.top, 40)
                    
                    
                    // Add button...
                    Button {
//                        alert3.present()
                        showCartAnimation = true
                        addToCart()
                       // alert3.present()
                    } label: {
//                        Text("\(isAddedToCart() ? "Added" : "Add") to Cart")
                        Text("\(isAddedToCart() ? "Remove from" : "Add to") Cart")
                            .font(.custom(secondaryFont, size: 20).bold())
                            .foregroundColor(.white)
                            //.padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                }
                
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .fullScreenCover(isPresented: $showCartAnimation, content: {
                CartAnimationView()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                          showCartAnimation = false
//                    }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    
//                }

            })
            .sheet(isPresented: $showDescription, content: {
                DescriptionView(product)
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(25)
            })
            .background(
                LinearGradient(colors: [Color.white, .appBlue], startPoint: .top, endPoint: .bottom)
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
                    Text("\(product.title) service is now in your Cart.")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(8)
                        .multilineTextAlignment(.center)
                })
                .onTapGesture {
                    alert3.dismiss()
                }
        }
    }
    @ViewBuilder
    func DescriptionView(_ product: EZProduct) -> some View {
        VStack( spacing: 6, content: {
            Text(product.description)
                .font(.custom(customFont, size: 20))
                .fontWeight(.semibold)
            Text("We have sent a verification email to your email address.\nPlease verify to continue.")
                .multilineTextAlignment(.center)
                .font(.custom(customFont, size: 14))
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.horizontal, 25)
        })

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
    @ViewBuilder
    func Website() -> some View {
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

