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
    @State private var showDescription: Bool = false
    @State private var showCartAnimation: Bool = false
    //Environment Variables
    @Environment(\.presentationMode) var mode
    //
    @State private var isInTheCart: Bool = false
    
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
                        .foregroundStyle(.black)
                    
                    Text("+1 (201) 366-4766")
                        .font(.custom(customFont, size: 16).bold())
                        .foregroundStyle(.black)
                       // .padding(.top)
                    
                    Text("tmitchell@ezlaundromat.net")
                        .font(.custom(customFont, size: 16).bold())
                        .accentColor(.red)
                        .foregroundStyle(.black)
                       // .padding(.top)
                    Text(.init("[Website](https://ezlaundromat.net//)"))
                        .accentColor(.black)
                    
                    
//                    Text(product.description)
//                        .font(.custom(customFont, size: 15))
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
                    
                    Button {
                        showDescription = true
                    } label: {
                        
                        // Since we need image at right...
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                                .font(.title2.bold())
                        }
//                        .font(.custom(customFont, size: 15).bold())
                        .font(.callout.bold())
                        .tint(.white)
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
                        Text("\(isAddedToCart() ? "Added" : "Add ") to Cart")
//                            .font(.custom(secondaryFont, size: 20).bold())
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            //.padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isAddedToCart())

                }
                
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .fullScreenCover(isPresented: $showCartAnimation, content: {
                CartAnimationView()

            })
            .sheet(isPresented: $showDescription, content: {
                DescriptionView(product)
                    .presentationCornerRadius(25)
                    .interactiveDismissDisabled()
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
        .onChange(of: isInTheCart, initial: false, { oldValue, newValue in
            if isInTheCart {
                self.mode.wrappedValue.dismiss()
            }
        })
    }
    @ViewBuilder
    func DescriptionView(_ product: EZProduct) -> some View {
        let headLines: [String] = ["Cleanliness is Key","Where clean meets convenience.", "Clean clothes, happy you!", "Bringing freshness to every thread.","We clean, you relax."].shuffled()
        ScrollView (showsIndicators: false){
            
            VStack( spacing: 10, content: {
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text(headLines.first!.capitalized)
                    .minimumScaleFactor(0.5)
                    .font(.title.bold())
                    .padding()
                    .foregroundStyle(Color.appBlue)
                    .background(Color.clear)
                    .cornerRadius(12.0)
                Text(product.description)
                    .font(.custom(customFont, size: 20))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300)
                Button(action: {}, label: {
                    Text("Schedule A Pickup")
                        .foregroundStyle(Color.primary)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .contentShape(.capsule)
                        .background {
                            Capsule()
                                .stroke(Color.primary, lineWidth: 0.5)
                        }
                })
                .frame(maxWidth: .infinity)
                .padding(20)
            })
            
        }
        .overlay(alignment: .topTrailing, content: {
            Button("Close") {
               showDescription = false
            }
            .padding(15)
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
            isInTheCart = true
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
struct PaddedButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color
    let cornerRadius: Double

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
    }
}

extension View {
    func paddedButtonStyle(foregroundColor: Color = .white,
                           backgroundColor: Color = Color.blue,
                           cornerRadius: Double = 6
    ) -> some View {
        self.buttonStyle(PaddedButtonStyle(foregroundColor: foregroundColor,
                                           backgroundColor: backgroundColor,
                                           cornerRadius: cornerRadius)
        )
    }
}

