//
//  EZProduct.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI
import SwiftData

//class EZProduct: Identifiable, Hashable {
//@Model
class EZProduct: Identifiable, Hashable, Decodable {
    static func == (lhs: EZProduct, rhs: EZProduct) -> Bool {
        lhs.id == rhs.id &&
        lhs.type == rhs.type &&
        lhs.subtitle == rhs.subtitle &&
        lhs.EZProductDescription == rhs.EZProductDescription &&
        lhs.price == rhs.price &&
        lhs.productImage == rhs.productImage &&
        lhs.quantity == rhs.quantity &&
//        lhs.deliveryType == rhs.deliveryType &&
        lhs.weight == rhs.weight
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    var id = UUID().uuidString
    var type: String
    var title: String
    var subtitle: String
    var EZProductDescription: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
//    var deliveryType: DeliveryType?
    var weight: Int?
    
    init(id: String = UUID().uuidString, type: EZProductType, title: String, subtitle: String, EZProductDescription: String, price: String, productImage: String, quantity: Int, weight: Int? = nil) {
        self.id = id
        self.type = type.rawValue
        self.title = title
        self.subtitle = subtitle
        self.EZProductDescription = EZProductDescription
        self.price = price
        self.productImage = productImage
        self.quantity = quantity
        self.weight = weight
    }
    
}

enum EZProductType: String, CaseIterable, Equatable, Hashable, Decodable {
    case washNFold = "Wash N fold"
    case mens = "Dry Clean Services"
    case womens = "Womens"
   
}
//enum DeliveryType: String, CaseIterable, Equatable, Hashable {
//    case pickUp = "Pick Up"
//    case delivery = "Delivery"
//}
