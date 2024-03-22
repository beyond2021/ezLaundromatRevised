//
//  EZCartPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI

// Since both of the views are mostly identical....
struct EZCartPage: View {
    @EnvironmentObject var sharedData: EZSharedDataModel
    
    // Delete Option...
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 10){
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack{
                        
                        HStack{
                            
                            Text("Cart")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)

                        }
                        
                        // checking if liked products are empty...
                        if sharedData.cartProducts.isEmpty{
                            
                            Group{
                                Image("NoBasket")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                    .padding(.top,35)
                                
                                Text("No Items added")
                                    .font(.custom(customFont, size: 25))
                                    .fontWeight(.semibold)
                                
                                Text("Hit the Add To Cart button to save into basket.")
                                    .font(.custom(customFont, size: 18))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top,10)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        else{
                         
                            // Displaying Products...
                            VStack(spacing: 15){
                                
                                // For Designing...
                                ForEach($sharedData.cartProducts){$product in
                                    
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
                                        
                                        EZCardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top,25)
                            .padding(.horizontal,10)
                        }
                    }
                    .padding()
                }
                
                // Showing Total and check out Button...
                if !sharedData.cartProducts.isEmpty{
                    
                    Group{
                        
                        HStack{
                            
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
//                                .foregroundColor(Color("Purple"))
                                .foregroundColor(Color.appBlue)
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Text("Checkout")
                                .modifier(EZButton())
//                                .font(.custom(customFont, size: 18).bold())
//                                .foregroundColor(.white)
//                                .padding(.vertical,18)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.appBlue)
//                                .cornerRadius(15)
//                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                    }
//                    .padding(.horizontal,25)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
               LinearGradient(colors: [Color.appBlue, Color.white], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: EZProduct){
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                // removing...
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct EZCartPage_Previews: PreviewProvider {
    static var previews: some View {
        EZCartPage()
    }
}

struct EZCardView: View{
    
    // Making Product as Binding so as to update in Real time...
    @Binding var product: EZProduct
    
    var body: some View{
        
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .contrast(5)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
//                    .font(.custom(customFont, size: 18).bold())
                    .font(.title2.bold())
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Text(product.price)
//                    .font(.custom(customFont, size: 17))
                    .font(.caption.bold())
                    .fontWeight(.semibold)
                    .foregroundColor(Color.appBlue)
                
                // Quantity Buttons...
                HStack(spacing: 10){
                    
                    Text("Quantity")
                        .font(.custom(customFont, size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
//                            .background(Color("Quantity"))
                            .background(Color.appBlue)
                            .cornerRadius(4)
                    }

                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.appBlue)
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
//            LinearGradient(colors: [Color.appBlue, .white], startPoint: .top, endPoint: .bottom)
        
            Color.white
                .cornerRadius(10)
        )
    }
}

