//
//  Cart.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 4/4/24.
//

import SwiftUI

struct Cart: View {
    @EnvironmentObject var sharedData: EZSharedDataModel
    var body: some View {
        ScrollView {
            HeaderView()
                .padding()
            if sharedData.paymentSuccess {
                //Thank the user
                Text("Thank you for your purchase! You'll get your spotlessly cleaned laundry soon! You'll also receive an email comformation shortly.")
                    .padding()
            } else {
                if sharedData.cartProducts.count > 0 {
                    ForEach(sharedData.cartProducts, id: \.id) { product in
                        ProductRow(product: product)
                            .padding(.horizontal)
                        
                        
                    }
                    .onDelete(perform: { indexSet in
                        delete(at: indexSet)
                    })
                    Spacer()
                    HStack {
                        Text("Your cart total is: ".uppercased())
                        Text("\(sharedData.getTotalPrice())")
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.top, 40)
                    PaymentButton(action: sharedData.pay)
                        .padding()
                    
                } else {
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
            }  //end
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .onDisappear {
            if sharedData.paymentSuccess {
                sharedData.paymentSuccess = false
            }
        }
//        .background(
////            Color.gray
//        
////           LinearGradient(colors: [Color.appBlue, Color.white], startPoint: .top, endPoint: .bottom)
////                .ignoresSafeArea(.all)
//        )
      
        
        
        
    }
    @ViewBuilder
    func HeaderView() -> some View {
        Text("CART")
            .font(.title)
    }
    func delete(at offsets: IndexSet) {
        sharedData.cartProducts.remove(atOffsets: offsets)
    }
    
}

#Preview {
    Cart()
}
