//
//  EZSharedDataModel.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI

let appTint:Color = Color.appBlue
extension Color {
    public static var appBlue: Color {
        return Color(UIColor(red: 5/255, green: 25/255, blue: 168/255, alpha: 1.0))
    }
}

class EZSharedDataModel: ObservableObject {
    // Apple Pay
    let paymentHandler = PaymentHandler()
    @Published  var paymentSuccess: Bool = false
    @Published  var total: Double  = 0.00
    
    //
    @Published var showCart = false
    
    // Detail Product Data....
    @Published var detailProduct: EZProduct?
    @Published var showDetailProduct: Bool = false
    
    // matched Geoemtry Effect from Search page...
    @Published var fromSearchPage: Bool = false
    
//    // matched Geoemtry Effect from Search page...
//    @Published var fromSearchPage: Bool = false
    
    // Liked Products...
    @Published var likedProducts: [EZProduct] = [] // Fills up and empties when LIKE is pressed
    
    // basket Products...
    @Published var cartProducts: [EZProduct] = []
    
    // calculating Total price...
    func getTotalPrice()->String{
        
        var total: Double = 0.0
        
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            let quantity: Double = Double(product.quantity)
            let priceTotal = quantity * price.doubleValue
            total += priceTotal
        }
        
        return "$\(total)"
    }
    
    func updatePrice(_ productAmount: Int, originalPrice: String) -> String {
        let amount: Double = Double(productAmount)
        let price = (originalPrice as NSString).doubleValue
        return String(price * amount)
    }
    
    //New Stuff
    func pay() {
        var total: Double = 0.0
        
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            let quantity: Double = Double(product.quantity)
            let priceTotal = quantity * price.doubleValue
            total += priceTotal
        }
        paymentHandler.startPayment(products: cartProducts, total:total) { success in
            self.paymentSuccess = success
            self.cartProducts = []
            self.cartProducts.removeAll()
        }
    }
    
    
    
////    @Published var showCart = false
//    @Published var selectedSize = ""
//    
//    // Animation Properties...
//    @Published var startAnimation = false
//    @Published var shoeAnimation = false
//    
//    @Published var showBag = false
//    @Published var saveCart = false
//    
//    @Published var additemtocart = false
//    
//    @Published var endAnimation = false
//    
//    // cart items...
//    @Published var cartItems = 0
//    
//    // performing Animations...
//    func performAnimations(){
//        
//        withAnimation(.easeOut(duration: 0.8)){
//            shoeAnimation.toggle()
//        }
//        
//        // chain Animations...
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
//            
//            withAnimation(.easeInOut){
//                self.showBag.toggle()
//            }
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
//            
//            withAnimation(.easeInOut(duration: 0.5)){
//                self.saveCart.toggle()
//            }
//        }
//        
//        // 0.75 + 0.5 = 1.25
//        // beecause to start animation before the shoe comes to cart...
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
//            
//            self.additemtocart.toggle()
//        }
//        
//        // end animation will start at 1.25....
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
//            
//            withAnimation(.easeInOut(duration: 0.5)){
//                self.endAnimation.toggle()
//            }
//        }
//    }
//    
//    func resetAll(){
//        
//        // giving some time to finish animations..
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[self] in
//            
//            withAnimation{
//                showCart.toggle()
//            }
//            
//            startAnimation = false
//            endAnimation = false
//            selectedSize = ""
//            additemtocart = false
//            showBag = false
//            shoeAnimation = false
//            saveCart = false
//            cartItems += 1
//        }
//    }
    
}

