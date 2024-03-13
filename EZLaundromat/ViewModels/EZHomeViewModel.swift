//
//  EZHomeViewModel.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI

// Using Combine to monitor search field and if user leaves for .5 secs then starts searching...
// to avoid memory issue...
import Combine

class EZHomeViewModel: ObservableObject {

//    @Published var productType: ProductType = .Wearable
    @Published var ezProductType: EZProductType = .washNFold
 
    @Published var ezProducts: [EZProduct] = [
        EZProduct( type: .mens, title: "The difference!", subtitle: "Coats Dry Cleaned", description: "Dry Clean", price: "14", productImage: "EZMensCoat001"),
        EZProduct( type: .mens, title: "Suits", subtitle: "Clean meets convenience.", description: "Dry Clean", price: "14", productImage: "EZMensSuit2"),
        EZProduct( type: .mens, title: "Dress Pants", subtitle: "Mens Pants", description: "Dry Clean", price: "10", productImage: "mensPants "),
        EZProduct( type: .mens, title: "Shirts", subtitle: "Mens Dress Shirts", description: "Dry Clean", price: "14", productImage: "EZMensShirt001"),
        EZProduct( type: .mens, title: "T Shirts", subtitle: "Mens T Shirst", description: "Dry Clean", price: "5", productImage: "MensTShirts"),
        EZProduct( type: .womens, title: "The difference.", subtitle: "Suits", description: "Dry Clean", price: "14", productImage: "EZWomenSuit001"),
        EZProduct( type: .womens, title: "Dress", subtitle: "Clean clothes, happy You", description: "Dry Clean", price: "10", productImage: "EZWomansDress001"),
        EZProduct( type: .womens, title: "Women's Pants.", subtitle: "Womens Pants", description: "Dry Clean", price: "14", productImage: "WPants"),
        
        EZProduct( type: .womens, title: "Suits", subtitle: "Womens Suits", description: "Dry Clean", price: "14", productImage: "EZWomensSuit001"),
        
        EZProduct( type: .washNFold, title: "Dirty Laundry?", subtitle: "Stains, meet you match.", description: "You can do your own laundry in our newly renovated Laundromat at 427 Anderson Avenue, Fairview NJ 07022. It’s in our store and is open during our normal business hours.", price: "50", productImage: "EZLaundryBasket"),
        EZProduct( type: .washNFold, title: "Bulk Laundry", subtitle: "Laundry made easy.", description: "Wash", price: "10", productImage: "EZWashingMaching001"),
        EZProduct( type: .washNFold, title: "Blankets", subtitle: "Your laundry, our passion.", description: "Wash", price: "14", productImage: "EZBlanket001"),
        
        
//        EZProduct( type: .shirts, title: "SHIRT ON HANGER", subtitle: "Mens T Shirst", description: "Dry Clean", price: "5", productImage: "EZMensShirt001"),
//        EZProduct( type: .womens, title: "Suits", subtitle: "Womens Suit", description: "Dry Clean", price: "14", productImage: "EZMensSuit"),
//        EZProduct( type: .womens, title: "Dresses", subtitle: "Women's Dresses", description: "Dry Clean", price: "10", productImage: "dress"),
//        EZProduct( type: .womens, title: "Pants", subtitle: "Womens Pants", description: "Dry Clean", price: "14", productImage: "WPants"),
        
    
    
    ]
    
    
    // Filtered Products...
    @Published var filteredProducts: [EZProduct] = []
    
    // More products on the type..
    @Published var showMoreProductsOnType: Bool = false
    
    // About US
    @Published var showAboutUs: Bool = false
    
    // Search Data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [EZProduct]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.ezProducts
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.type == self.ezProductType
                }
            // Limiting result...
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.ezProducts
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}

