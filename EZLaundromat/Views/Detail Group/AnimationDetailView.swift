//
//  AnimationDetailView.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/29/24.
//

import SwiftUI
import AVFoundation
import MessageUI
import EmailComposer

struct AnimationDetailView: View {
    var product: EZProduct
    @Namespace var newAnimation
    // For Matched Geometry Effect...
    var animation: Namespace.ID
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
    @State private var productQuantity: Int = 1
    @State private var productPrice: String = ""
    @State private var player: AVAudioPlayer?
    @State private var isInTheCart: Bool = false
    @State private var animationLike: Bool = false
    @State private var offset: CGFloat = 0.0
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    var session:AVAudioSession = AVAudioSession()
    @AppStorage("showNewDetail") private var showNewDetail: Bool = false
    let emailData = EmailData(subject: "Hi there!",recipients: ["tmitchell@ezlaundromat.net"])
    var body: some View {
        ZStack{
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
                                .frame(width: 30, height: 30)
                                .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                                .shadow(radius: 10.0)
//                                .offset(y: offset)
//                                .onTapGesture { offset -= 100.0 }
//                                .animation(Animation.easeInOut(duration: 1.0), value: offset)
//                                .offset(y: offset)
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
                                .background(Color.appPurple)
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
                        .zIndex(-1)
                    
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
                .overlay(alignment: .bottom){
                    Label(
                        title: { Text("Tap To Order") },
                        icon: { Image(systemName: "42.circle") }
                    )
                    .opacity(showCart ? 0 : 1)
                    .padding(.vertical, 50)
                }
                .zIndex(-1)
                Spacer()
                    .background(
                        LinearGradient(colors: [Color.white, .appPurple], startPoint: .top, endPoint: .bottom)
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
                    .zIndex(2)
                    
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
            
            .background(LinearGradient(colors: [.white, .appPurple], startPoint: .top, endPoint: .bottom))
            .onChange(of: endAnimation, initial: false, { oldValue, newValue in
                if endAnimation{
                    
                    // reset...
                    resetAll()
                }
            })
            
            .onAppear {
                productPrice = product.price
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // 1 sec delay
                    withAnimation {
                        showDetailText.toggle()
                    }
                    
                }
            }
           
            
            if animationLike {
//                withAnimation {
//                    LikeView(isLiked: $animationLike)
//                }
               
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
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(product.title.uppercased())
//                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.trailing)
                    HStack {
                        Text("$\(productPrice)")
                        //                                .font(.caption.bold().uppercaseSmallCaps())
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text(product.type == "Wash N fold" ? "per pound." : "each")
                            .font(.caption.bold())
                            .foregroundColor(.secondary)
                            .opacity(productQuantity == 1 ? 1.0 : 0.0 )
                    }
                })
            }
            .padding(.top)
            Divider()
            if !sharedData.cartProducts.contains(product) {
                let poundType = product.type == "Wash N fold" && productQuantity == 1 ? "POUND" : "POUNDS"
                let eachType = product.type != "Wash N fold" && productQuantity == 1 ? "PIECE" : "PIECES"
                let pd = product.type == "Wash N fold" ? poundType : eachType
                
                // Laundry Types....
                Stepper("\(productQuantity) \(pd)", value: $productQuantity, in: 1...50)
                    .font(.callout.bold())
                    .foregroundStyle(productQuantity == 0 ? Color.appBlue : .white)
                    .tint(productQuantity == 0 ? Color.appBlue : .red)
                    .onChange(of: productQuantity, initial: false) { oldValue, newValue in
                        withAnimation {
                            product.quantity = productQuantity
                            productPrice = updatePrice(product.quantity, originalPrice: product.price)   
                        }
                        
                    }
                    .padding(.horizontal, 15)
                    .disabled( false)
                HStack {
                    Button("CANCEL"){
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
                        Button("DESCRIPTION") {
                            resetAll()
                            withAnimation {
                                showDescription = true
                            }
                        }
                    }
                }
                .foregroundStyle(productQuantity == 0  ? Color.appBlue : .white)
                .fontWeight(.semibold)
                .padding()
                // Add to cart Button...
                Button(action: {
                    isInTheCart = true
                    withAnimation(.easeInOut(duration: 0.7)){
                        addToCart()
                        startAnimation.toggle()
                        showDetailText.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        playSound()
                    }
                }, label: {
                    Text("ADD TO CART")
                        .fontWeight(.bold)
                        .foregroundColor(productQuantity == 0 ? .black : .white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(productQuantity == 0 ? Color.black.opacity(0.06) : .appPurple)
                        .cornerRadius(18)
                })
                // disabling button when no size selected...
                .disabled(productQuantity == 0 || isInTheCart == true)
                .padding(.top)
                .sensoryFeedback(.selection, trigger: startAnimation)
            } else {
                Button(action: {
                    withAnimation {
                    if let index = sharedData.cartProducts.firstIndex(where: { product in
                        return self.product.id == product.id
                    }){
                        
                            sharedData.cartProducts.remove(at: index)
                        }
                    }
                }, label: {
                    Text("REMOVE")
                        .fontWeight(.bold)
                })
                .foregroundStyle(.red)
            }
        }
            .frame(height: 400)
            .padding()
//            .padding(.bottom,edges == 0 ? 15 : 0)
            .background(LinearGradient(colors: [.white, .appPurple], startPoint: .top, endPoint: .bottom).clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 35)))
//            .background(Color.appBlue)
           

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
                    Button(action: {
                        self.isShowingMailView.toggle()
                    }, label: {
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
                    .disabled(!MFMailComposeViewController.canSendMail())
                    .padding(20)

                    .emailComposer(isPresented: $isShowingMailView, emailData: emailData, result:  { result in
                        switch result {
                        case .success(let value):
                            if value == .deviceCannotSendEmails {
                                print(("Device cannot send emails."))
                            }
                            print(value.description)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })

                    
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
            isInTheCart = false
        }
    }
    func addToCart(){
        if !sharedData.cartProducts.contains(product) {
            sharedData.cartProducts.append(product)
            isInTheCart = true
        } else {
           print("Already in cart")
        }

    }
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }

    func removeFromCart() {
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.cartProducts.remove(at: index)
        }
    }
    
    func addToLiked(){

        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked.... Dislike!
            sharedData.likedProducts.remove(at: index)
            animationLike = false
        }
        else{
            // add to liked..... LIKE
            sharedData.likedProducts.append(product)
            animationLike = true
        }
    }
    @ViewBuilder
    func showResetView() -> some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 100)
        
    }
    func updatePrice(_ productAmount: Int, originalPrice: String) -> String {
        let amount: Double = Double(productAmount)
        let price = (originalPrice as NSString).doubleValue
        return String(price * amount)
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

//var edges = UIApplication.shared.windows.first?.safeAreaInsets.bottom


let sizes = ["1","2","3","4"]
func *(lhs:Double, rhs:Int) -> Double {
    return lhs * Double(rhs)
}
