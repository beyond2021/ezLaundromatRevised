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
    
    // Detail Product Data....
    @Published var detailProduct: EZProduct?
    @Published var showDetailProduct: Bool = false
    
    // matched Geoemtry Effect from Search page...
    @Published var fromSearchPage: Bool = false
    
    // Liked Products...
    @Published var likedProducts: [EZProduct] = []
    
    // basket Products...
    @Published var cartProducts: [EZProduct] = []
    
    // calculating Total price...
    func getTotalPrice()->String{
        
        var total: Int = 0
        
        cartProducts.forEach { product in
            
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        
        return "$\(total)"
    }
}

