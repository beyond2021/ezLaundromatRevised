//
//  EZProfilePage.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI
import Firebase

struct EZProfilePage: View {
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    //pre iOS16
    @State var imagePickerPresented = false
    @Environment(\.presentationMode) var mode
    //
    @AppStorage("log_status") private var logStatus: Bool = false
    
    var body: some View {
        
        NavigationStack{
            HeaderView()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                   
             
//                    .background(
//                    
//                        Color.white
//                            .cornerRadius(12)
//                    )
//                    .padding()
//                    .padding(.top,40)
                    
                    // Custom Navigation Links...
                        
                        CustomNavigationLink(title: "Edit Profile") {
                            
                            Text("")
                                .navigationTitle("Edit Profile")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("HomeBG").ignoresSafeArea())
                        }
                        
                        
                        CustomNavigationLink(title: "Shipping address") {
                            
                            Text("")
                                .navigationTitle("Shopping address")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("HomeBG").ignoresSafeArea())
                        }
                        
                        CustomNavigationLink(title: "Order history") {
                            
                            Text("")
                                .navigationTitle("Order history")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("HomeBG").ignoresSafeArea())
                        }
                        
                        CustomNavigationLink(title: "Cards") {
                            
                            Text("")
                                .navigationTitle("Cards")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("HomeBG").ignoresSafeArea())
                        }
                        
                        CustomNavigationLink(title: "Notifications") {
                            
                            Text("")
                                .navigationTitle("Notifications")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("HomeBG").ignoresSafeArea())
                        }
    
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                            Button("Press Me") {
//                                print("Pressed")
//                            }
//                        }
//                    }
            .toolbar {
                            ToolbarItem(placement: .principal) { Text("List").foregroundColor(.white) }
                        }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
              LinearGradient(colors: [Color.appBlue, .white], startPoint: .top, endPoint: .bottom)

                    .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                            Button("Press Me") {
                                print("Pressed")
                            }
                        }
                    }
//            .toolbar(content: {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Log Out.") {
//                        
//                    }
//                }
//            })
        }
    }
    
    // Avoiding new Structs...
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)->some View{
        
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
            
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
    @ViewBuilder
    func HeaderView() -> some View {
        Text("My Profile")
            .font(.custom(customFont, size: 28).bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
        
        VStack(spacing: 15){
            
//            Image("lbj")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
//                .offset(y: -30)
//                .padding(.bottom,-30)
            //
            if let image = image {

                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .foregroundColor(.white)



                .padding()


            } else {

                Button(action: {imagePickerPresented.toggle()}) {
                    VStack {
                        Image(systemName: "plus").font(.title).padding(.bottom, 4)
                        Text("Photo").font(.headline)
                    }
                }
                .padding(30)
                .foregroundColor(Color.appBlue)
                .overlay(
                    Circle()
                        .stroke(Color.appBlue, lineWidth: 2)
                )
                .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage) {
                     // ImagePicker(image: $selectedImage)
                    TwitImagePicker(selectedImage: $selectedImage)

                }
                .padding()
         }
    
            
            
            
            //
            
            Text("Lebron James")
                .font(.custom(customFont, size: 16))
                .fontWeight(.semibold)
            
            HStack(alignment: .top, spacing: 10) {
                
                Image(systemName: "location.north.circle.fill")
                    .foregroundColor(.gray)
                    .rotationEffect(.init(degrees: 180))
                
                Text("Address: 94 Amsterdam Ave, Teaneck NJ")
                    .font(.custom(customFont, size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding([.horizontal,.bottom, .top])
        .overlay(alignment: .topTrailing, content: {
//            Button("Log Out.") {
//
//            }
            Button(action: logout, label: {
                Text("Log Out")
                    .font(.title2.bold())
                    .tint(Color.appBlue)
            })
            .padding(15)
        })
        .padding(.bottom, 15)
    }
    func logout() {
        try? Auth.auth().signOut()
        logStatus = false
    }
}

struct EZProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        EZProfilePage()
    }
}

// Add the image
extension EZProfilePage {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
}
