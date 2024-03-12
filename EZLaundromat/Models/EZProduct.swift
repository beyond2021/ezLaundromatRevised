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
//    case kids = "Kids Services"
    //
//    case shirts = "Shirts"
//    case tops = "Tops"
//    case bottoms = "Bottoms"
//    case dresses = "Dresses"
//    case homeItems = "Home Items"
//    case outerWear = "Outer Wear"
//    case accessoriesAndHomeWear = "Accessories and Homewaer"
//    case bedSheets = "Bed Sheets"
//    case duvetCovers = "Duvet Covers"
//    case pillowCaseAndCushionCovers = "Pillow case and cushion covers"
//    case bathroomItems = "Bathroom Items"
//    case dining = "Dining"
//    case miscellaneous = "Miscellaneous"
    
}
enum DeliveryType: String, CaseIterable {
    case pickUp = "Pick Up"
    case delivery = "Delivery"
}
