//
//  AnimationDetailView.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/29/24.
//

import SwiftUI
import AVFoundation

struct AnimationDetailView: View {
    var product: EZProduct
    @Namespace var newAnimation
    // For Matched Geometry Effect...
    var animation: Namespace.ID
    // Shared Data Model...
    // Shared Data Model...
//    @EnvironmentObject var sharedData: EZSharedDataModel
    @EnvironmentObject var sharedData: EZSharedDataModel
    
    @EnvironmentObject var homeData: EZHomeViewModel
    //
    @State private var showDescription: Bool = false
    @State private var showCartAnimation: Bool = false
    //Environment Variables
    @Environment(\.presentationMode) var mode
    @Binding var tabSelection: Tab
    @State private var showCart: Bool = false
    @State private var endAnimation: Bool = false
    @State private var startAnimation: Bool  = false
    @State private var showBag: Bool  = false
    @State private var selectedSize: String  = ""
    @State private var shoeAnimation: Bool  = false
    @State private var saveCart: Bool  = false
    @State private var additemtocart: Bool  = false
    @State private var showDetailText: Bool  = false
    @State private var resetView: Bool  = false
    @State private var finalPrice: String = ""
    @State private var productAmount: Int = 0
    @State private var player: AVAudioPlayer?
   
   
    var body: some View {
        VStack{
            VStack{
                // Title Bar...
                HStack{
                    Button {
                        // Closing View...
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }
                    
                    
                }
                .overlay(
                    
                    Button(action: {
                        withAnimation {
                            tabSelection = .Cart
                            sharedData.showDetailProduct = false
                        }
                        
                    }, label: {
                        Image(systemName: "bag.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.appBlue)
                            .clipShape(Circle())
                            .overlay(
                                
                                Text("\(sharedData.cartProducts.count)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.orange)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -10)
                                    .opacity(sharedData.cartProducts.count != 0 ? 1 : 0)
                            )
                    })
                    
                )
                .padding(.top, 50)
                .padding(.bottom, 40)
                .padding(.horizontal)
                // Product Image...
                // Adding Matched Geometry Effect...
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                
            }
            .padding(.top)
            .padding(.bottom, -100)
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            .onTapGesture {
                withAnimation {
                    showDetailText.toggle()
                    showCart = true
                }
            }
            .blur(radius: showCart ? 50 : 0)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding(.top)
            Spacer()
                .background(
                    LinearGradient(colors: [Color.white, .appBlue], startPoint: .top, endPoint: .bottom)
                    // Corner Radius for only top side....
                        .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                        .ignoresSafeArea()
                )
            if showDetailText {
             
                    VStack( spacing: 5) {
                        
                        Text(product.title)
                        //                        .font(.custom(customFont, size: 30).bold())
                            .font(.title.bold())
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text(product.subtitle)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text("427 Anderson Avenue, Fairview NJ 07022")
                            .font(.custom(customFont, size: 12).bold())
                            .foregroundStyle(.white)
                        
                        Text("+1 (201) 366-4766")
                            .font(.custom(customFont, size: 16).bold())
                            .foregroundStyle(.white)
                        // .padding(.top)
                        
                        Text("tmitchell@ezlaundromat.net")
                            .font(.custom(customFont, size: 16).bold())
                            .accentColor(.red)
                            .foregroundStyle(.white)
                        // .padding(.top)
                        Text(.init("[Website](https://ezlaundromat.net//)"))
                            .accentColor(.white)
                        
                      
                        
                    }
              
            .padding(.horizontal)
            .frame(height: 100)
            .frame(maxWidth: .infinity,alignment: .center)
            .offset(y: 200)
      
    }
            AddToCartAnimation(animation: newAnimation, product: product)
                .padding(.bottom)
//                    .background(Color.clear)
                // hiding view when shoe is not selected...
                // like Bottom Sheet...
                // also closing when animation started...
                .offset(y: showCart ? startAnimation ? 500 : 0 : 500)
                if startAnimation{
                    
                    VStack{
                        
                        Spacer()
                        
                        ZStack{
                            
                            // Circle ANimatio Effect...
                            
                            Color.white
                                .frame(width: shoeAnimation ? 100 : getRect().width * 1.3, height: shoeAnimation ? 100 : getRect().width * 1.3)
                                .clipShape(Circle())
                            // Opacit...
                                .opacity(shoeAnimation ? 1 : 0)
                            
                            Image(product.productImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: "SHOE", in: animation)
                                .frame(width: 80, height: 80)
                        }
                        .offset(y: saveCart ? 70 : -600)
                        // scaling effect...
                        .scaleEffect(saveCart ? 0.6 : 1)
                        .onAppear(perform:performAnimations)
                        
                        if !saveCart{
                            Spacer()
                        }
                        
                        Image(systemName: "bag\(additemtocart ? ".fill" : "")")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(additemtocart ? Color.purple : Color("orange"))
                            .clipShape(Circle())
                            .offset(y: showBag ? -50 : 300)
                    }
                    // setting external view width to screen width..
                    .frame(width: getRect().width)
                    // moving view down...
                    .offset(y: endAnimation ? 500 : 0)
                }
            
        }
        .sheet(isPresented: $showDescription, content: {
            
                DescriptionView(product)
                    .presentationCornerRadius(25)
                    .interactiveDismissDisabled()
                    .padding(.top)
                
        
            
        })
        .background(LinearGradient(colors: [.white, .appBlue], startPoint: .top, endPoint: .bottom))
        .onChange(of: endAnimation, initial: false, { oldValue, newValue in
            if endAnimation{
                
                // reset...
                resetAll()
            }
        })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // 1 sec delay
                withAnimation {
                    showDetailText.toggle()
                }
                
                }
            
            
        }
    }
    
    //
    @ViewBuilder
    func AddToCartAnimation( animation: Namespace.ID, product: EZProduct ) -> some View {
        
            VStack{
                HStack(spacing: 15){
                    if !startAnimation{
                        Image(product.productImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .matchedGeometryEffect(id: "SHOE", in: newAnimation)
                    }
                    
                    Rectangle()
                        .foregroundStyle(.black)
                        .frame(width: 1, height: 80)
                    
                    VStack(alignment: .trailing, spacing: 10, content: {
                        Text(product.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.appBlue)
                            .multilineTextAlignment(.trailing)
                        HStack {
                            Text("$\(product.price)")
//                                .font(.caption.bold().uppercaseSmallCaps())
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Text(product.type == "Wash N fold" ? "per pound" : "each")
                                .font(.caption.bold())
                                .foregroundColor(.gray)
                        }
                    })
                }
                .padding(.top)
                Divider()
//                Text("NUMBER OF BAGS")
//                    .font(.caption)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.black)
//                    .padding(.vertical)
                // Laundry Types....
                Stepper("AMOUNT: \(productAmount)", value: $productAmount, in: 0...50)
                    .font(.caption.bold())
                    .foregroundStyle(productAmount == 0 ? Color.appBlue : .white)
                    .tint(productAmount == 0 ? Color.appBlue : .red)
                    .onChange(of: productAmount, initial: false) { oldValue, newValue in
                        withAnimation {
                            finalPrice = updatePrice(productAmount, originalPrice: product.price)
                        }
                        
                    }
                    .padding(.horizontal, 15)
                
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 4)
//                LazyVGrid(columns: columns, alignment: .leading, spacing: 10, content: {
//                    ForEach(sizes,id: \.self){size in
//                        Button(action: {
//                            withAnimation{
//                                selectedSize = size
//                                finalPrice = updatePrice(selectedSize, originalPrice: product.price)
//                            }
//                        }, label: {
//                            if product.type == "Wash N fold" {
//                                if size == "1" {
//                                    Text("\(size) pound")
//                                        .font(.caption)
//                                        .lineLimit(1)
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(selectedSize == size ? .white : .black)
//                                        .padding(.vertical,5)
//                                        .frame(maxWidth: .infinity)
//                                        .background(selectedSize == size ? .appBlue : Color.black.opacity(0.06))
//                                        .cornerRadius(10)
//                                } else {
//                                    Text("\(size) pounds")
//                                        .font(.caption)
//                                        .lineLimit(1)
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(selectedSize == size ? .white : .black)
//                                        .padding(.vertical,5)
//                                        .frame(maxWidth: .infinity)
//                                        .background(selectedSize == size ? .appBlue : Color.black.opacity(0.06))
//                                        .cornerRadius(10)
//                                }
//                            } else {
//                                if size == "1" {
//                                    Text("\(size) piece")
//                                        .font(.caption)
//                                        .lineLimit(1)
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(selectedSize == size ? .white : .black)
//                                        .padding(.vertical,5)
//                                        .frame(maxWidth: .infinity)
//                                        .background(selectedSize == size ? .appBlue : Color.black.opacity(0.06))
//                                        .cornerRadius(10)
//                                } else {
//                                    Text("\(size) pieces")
//                                        .font(.caption)
//                                        .lineLimit(1)
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(selectedSize == size ? .white : .black)
//                                        .padding(.vertical,5)
//                                        .frame(maxWidth: .infinity)
//                                        .background(selectedSize == size ? .appBlue : Color.black.opacity(0.06))
//                                        .cornerRadius(10)
//                                }
//                            }
//                        })
//                    }
//                })
                HStack {
                    Button("Cancel"){
                        resetAll()
                    }
                    Spacer()
                    Rectangle()
                        .frame(width: 1, height: 40)
                    Spacer()
                    if finalPrice != "" {
                        withAnimation {
                            Text("TOTAL PRICE: $\(finalPrice)")
                        }
                    } else {
                            Button("Description") {
                                resetAll()
                                withAnimation {
                                    showDescription = true
                                }
                            }
                    }
                }
                .foregroundStyle(productAmount == 0 ? Color.appBlue : .white)
                .fontWeight(.semibold)
                .padding()
                // Add to cart Button...
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.7)){
                        addToCart()
                        startAnimation.toggle()
                        showDetailText.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        playSound()
                    }
                }, label: {
                    Text("Add to cart")
                        .fontWeight(.bold)
                        .foregroundColor(productAmount == 0 ? .black : .white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(productAmount == 0 ? Color.black.opacity(0.06) : .appBlue)
                        .cornerRadius(18)
                })
                // disabling button when no size selected...
                .disabled(productAmount == 0)
                .padding(.top)
                .sensoryFeedback(.selection, trigger: startAnimation)
            }
            .frame(height: 400)
            .padding()
            .padding(.bottom,edges == 0 ? 15 : 0)
            .background(LinearGradient(colors: [.white, .appBlue], startPoint: .top, endPoint: .bottom).clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 35)))
        

    }
    @ViewBuilder
    func DescriptionView(_ product: EZProduct) -> some View {
        let headLines: [String] = ["Cleanliness is Key","Where clean meets convenience.", "Clean clothes, happy you!", "Bringing freshness to every thread.","We clean, you relax."].shuffled()
        ScrollView (showsIndicators: false){
            
            VStack( spacing: 10, content: {
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text(headLines.first!.capitalized)
                    .minimumScaleFactor(0.5)
                    .font(.title.bold())
                    .padding()
                    .foregroundStyle(Color.appBlue)
                    .background(Color.clear)
                    .cornerRadius(12.0)
                Text(product.EZProductDescription)
                    .font(.custom(customFont, size: 20))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300)
                Button(action: {}, label: {
                    Text("Schedule A Pickup")
                        .foregroundStyle(Color.primary)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .contentShape(.capsule)
                        .background {
                            Capsule()
                                .stroke(Color.primary, lineWidth: 0.5)
                        }
                })
                .frame(maxWidth: .infinity)
                .padding(20)
            })
            
        }
        .overlay(alignment: .topTrailing, content: {
            Button("Close") {
               showDescription = false
            }
            .padding(15)
        })
    }
    func performAnimations(){
        
        withAnimation(.easeOut(duration: 0.8)){
            shoeAnimation.toggle()
        }
        
        // chain Animations...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            
            withAnimation(.easeInOut){
                showBag.toggle()
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
            finalPrice = ""
            showDetailText = true
            productAmount = 0
            
//            cartItems += 1
        }
    }
    func addToCart(){
        sharedData.cartProducts.append(product)
        
//        if let index = sharedData.cartProducts.firstIndex(where: { product in
//            return self.product.id == product.id
//        }){
//            // Remove from liked....
//            sharedData.cartProducts.remove(at: index)
//        }
//        else{
//            // add to liked
//            sharedData.cartProducts.append(product)
////            isInTheCart = true
            
 //       }
    }
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){

        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked.... Dislike!
            sharedData.likedProducts.remove(at: index)
        }
        else{
            // add to liked..... LIKE
            sharedData.likedProducts.append(product)
        }
    }
    @ViewBuilder
    func showResetView() -> some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 100)
        
    }
    func updatePrice(_ productAmount: Int, originalPrice: String) -> String {
        let bagCount = String(productAmount)
        let bagAmount = Double(originalPrice) ?? 0.0
        let total = bagAmount * Double(bagCount)!
        return String(total)
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "swoosh-sound-effect-for-fight-scenes-or-transitions-2-149890", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

var edges = UIApplication.shared.windows.first?.safeAreaInsets.bottom


let sizes = ["1","2","3","4"]
func *(lhs:Double, rhs:Int) -> Double {
    return lhs * Double(rhs)
}
   
