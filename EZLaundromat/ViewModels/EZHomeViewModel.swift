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
        EZProduct(type: .mens, title: "Long Coats and Rain Jackets Cleaned", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription:  " Most raincoats can be cleaned this way unless they contain polyurethane, which will crack or flake off during the process.", price: "35", productImage: "EZLongCoats", quantity: 1),
        EZProduct( type: .mens, title: "Tuxedo and Short Coats", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: "In the bustling heart of Fairview, where every minute counts, EZLaundry's Cleaners (EZ) stands as the beacon of convenience and innovation for discerning professionals. Founded by Trevor himself, a former Business Tech, EZ was born from a vision to revolutionize dry cleaning and laundry services. We’re not your run-of-the-mill dry cleaner; open 6 days a week, EZ breaks the mold, making dry cleaning fit your schedule, not the other way around.", price: "32", productImage: "EZMensCoat001", quantity: 1),
        EZProduct( type: .mens, title: "Suits", subtitle: "Eco-Friendly Dry Cleaning.", EZProductDescription: """
• Garment Care: From suits and dresses to jackets and blouses, we specialize in cleaning a wide range of garments to perfection.
• Stain Removal: Our expert stain removal techniques can tackle even the toughest stains, ensuring your clothes look flawless.
• Alterations and Repairs: In addition to cleaning, we offer alteration and repair services to ensure your garments fit you perfectly and last for years to come.
• Household Items: We don't just stop at clothing. We also clean household items such as curtains, bedding, and linens, helping you maintain a fresh and clean home.
""", price: "14", productImage: "EZMensSuit2", quantity: 1),
        EZProduct( type: .mens, title: "Dress Pants", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: """
• Expertise: Our team consists of highly skilled professionals who understand the delicate nature of different fabrics and garments. Whether it's your everyday attire, delicate silk dresses, or tailored suits, we have the expertise to handle them all with care.
""", price: "14", productImage: "mensPants", quantity: 1),
        EZProduct( type: .mens, title: "Shirt on hanger", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: """
• Advanced Technology: We utilize cutting-edge dry cleaning technology and eco-friendly solvents to effectively remove stains, odors, and dirt while preserving the integrity of your clothing.
""", price: "14", productImage: "EZMensShirt001", quantity: 1),
        EZProduct( type: .washNFold, title: "Folded T Shirts", subtitle: "Wash and Fold Laundry Services\nBilled per Pound", EZProductDescription: """
In contrast, dry cleaning is a much more involved process than wash and fold. First, your clothes are inspected, treated for stains, then cleaned with a chemical solvent. No water is used in dry cleaning! Clothes are gently washed in the solvent to cause the soils, stains, and oils to loosen. These garments are then either steamed or pressed to remove wrinkles.
""", price: "3.69", productImage: "EZWashNFoldTShirts", quantity: 1),
//        EZProduct( type: .womens, title: "Womens Suits.", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: "If you only wear a suit now and then, store it in a breathable suit bag – not nylon and not plastic dry cleaning bags. Give it some room, don’t pack suits tightly in a dark closet. If you have room, hang clothes a few inches apart to avoid crushing and allow air circulation.How often you should dry clean a suit depends heavily on your workday, environment, and how many suits you own. People wearing suits can have very different workdays.", price: "14", productImage: "EZWomenSuit001", quantity: 1),
        EZProduct( type: .womens, title: "Dress", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: "In the Victorian era, women’s clothing was just as likely to spot, stain, and soil as it is today. For fine fabrics, this posed a particular dilemma. Ladies couldn’t simply throw their printed muslin dresses into a washing machine or send their silk ball gowns to the dry cleaners. Instead, they relied on their lady’s maids to keep their clothing clean and in good order. Not only would a competent lady’s maid know how to sponge and press a gown for wear, she would also know precisely how to wash a delicate muslin or remove an oil stain from silk.", price: "10", productImage: "EZWomansDress001", quantity: 1),
        EZProduct( type: .womens, title: "Women's Pants.", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: "Dry Clean", price: "14", productImage: "WPants", quantity: 1),
        
        EZProduct( type: .womens, title: "Suits", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: "Dry Clean", price: "14", productImage: "EZWomensSuit001", quantity: 1),
//        EZProduct( type: .womens, title: "Silk Blouse, Cashmere Sweater, Blazer, Scarf", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: "Dry Clean", price: "15", productImage: "EZWomensSuit001", quantity: 1),
        EZProduct( type: .womens, title: "Sweaters", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription: "Dry Clean", price: "15", productImage: "Sweater", quantity: 1),
        
        EZProduct( type: .washNFold, title: "Dirty Laundry!", subtitle: "Wash and Fold Laundry Services\nBilled per Pound", EZProductDescription: "Because we have our own Laundromat and control the entire process, we have the ability to maintain high standards for cleanliness. We hope that we can serve as a model for the rest of the laundry industry in Fairfield and that these standards will be adopted by all. Washers and dryers are scrubbed throughout the day and flushed with vinegar. Surfaces and touch-points are cleaned with Lysol. All staff wear gloves when handling dirty garments and wear latex disposable gloves when folding your clothes. Masks are worn at all times. We have a new video surveillance system to ensure cleaning procedures are being followed and to effectively track all clothing handled in our facility. We weigh your bag before and after cleaning to ensure that you receive whatever you give us. Stop by and take a look..", price: "3.69", productImage: "EZLaundryBasket", quantity: 1),
        EZProduct( type: .washNFold, title: "Bulk Laundry", subtitle: "Wash and Fold Laundry Services\nBilled per Pound", EZProductDescription: "Welcome to a new laundry experience for 2024. Your laundry problems are solved…We have listened to your suggestions, responded to your requests and enhanced our services for you! EZLaundromat  handles special requests, hang/air drying for gym clothes or delicates and the ability to provide special instructions for water/dryer temperature, fold method or anything else", price: "3.69", productImage: "EZWashingMaching001", quantity: 1),
        EZProduct( type: .washNFold, title: "Blankets", subtitle: "Wash and Fold Laundry Services\nBilled per Pound", EZProductDescription: "We never outsource your laundry or mix your clothes with anyone else’s (Yes, we know it’s gross but that’s how it’s done by most “laundry” companies in New Jersey.) If you’re wondering how they manage to keep track of your laundry, it’s placed in a large mesh bag and washed in the same machines as multiple other people in large factories in Newark and Paterson. New Jerseyians are savvy enough to know that you get what you pay for. All laundry at EZLaundry is done in our own Laundromat at 427 Anderson Avenue, Fairview NJ 07022. Extra wash and rinse cycles are always included. We control the entire process, which helps to eliminate lost socks.", price: "3.69", productImage: "EZBlanket001", quantity: 1),
        
        
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
    
    
    // NEW
    @Published var showCart = false
    @Published var selectedSize = ""
    
    // Animation Properties...
    @Published var startAnimation = false
    @Published var shoeAnimation = false
    
    @Published var showBag = false
    @Published var saveCart = false
    
    @Published var additemtocart = false
    
    @Published var endAnimation = false
    
    // cart items...
    @Published var cartItems = 0
    //
    
    
    
    
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
                    
                    return product.type == self.ezProductType.rawValue
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
        // New
        // performing Animations...
        func performAnimations(){
            
            withAnimation(.easeOut(duration: 0.8)){
                shoeAnimation.toggle()
            }
            
            // chain Animations...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                
                withAnimation(.easeInOut){
                    self.showBag.toggle()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                
                withAnimation(.easeInOut(duration: 0.5)){
                    self.saveCart.toggle()
                }
            }
            
            // 0.75 + 0.5 = 1.25
            // beecause to start animation before the shoe comes to cart...
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                
                self.additemtocart.toggle()
            }
            
            // end animation will start at 1.25....
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                
                withAnimation(.easeInOut(duration: 0.5)){
                    self.endAnimation.toggle()
                }
            }
        }
        
        func resetAll(){
            
            // giving some time to finish animations..
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[self] in
                
                withAnimation{
                    showCart.toggle()
                }
                
                startAnimation = false
                endAnimation = false
                selectedSize = ""
                additemtocart = false
                showBag = false
                shoeAnimation = false
                saveCart = false
                cartItems += 1
            }
        }
    }
    func resetAll(){
        
        // giving some time to finish animations..
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[self] in
            
            withAnimation{
                showCart.toggle()
            }
            
            startAnimation = false
            endAnimation = false
            selectedSize = ""
            additemtocart = false
            showBag = false
            shoeAnimation = false
            saveCart = false
            cartItems += 1
        }
    }
    
    
    
    
    
    
    
}

