//
//  EZSharedDataModel.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI
import UIKit

let appTint:Color = Color.appBlue
extension Color {
    public static var appBlue: Color {
        return Color(UIColor(red: 5/255, green: 25/255, blue: 168/255, alpha: 1.0))
    }
    // 20063B
    public static var appPurple: Color {
        return Color(UIColor(red: 32/255, green: 0/255, blue: 59/255, alpha: 1.0))
    }
    //CC3363
    public static var appPink: Color {
        return Color(UIColor(red: 204/255, green: 51/255, blue: 99/255, alpha: 1.0))
    }
    public static var appLightBlue: Color {
        return Color(UIColor(red: 154/255, green: 209/255, blue: 212/255, alpha: 1.0))
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
    
}

