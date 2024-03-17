//
//  EZProduct.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI

struct EZProduct: Identifiable,Hashable {
    var id = UUID().uuidString
    var type: EZProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
    var deliveryType: DeliveryType?
    var weight: Int?
    
}

enum EZProductType: String, CaseIterable {
    case washNFold = "Wash N fold"
    case mens = "Dry Clean Services"
    case womens = "Womens"
   
}
enum DeliveryType: String, CaseIterable {
    case pickUp = "Pick Up"
    case delivery = "Delivery"
}
