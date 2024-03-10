//
//  EZProfilePage.swift
//  EcommerceAppKit (iOS)
//
//  Created by KEEVIN MITCHELL on 3/7/24.
//

import SwiftUI
import Firebase

struct EZProfilePage: View {
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.white)
                    
                    VStack(spacing: 15){
                        
                        Image("lbj")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom,-30)
                        
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
                    .padding([.horizontal,.bottom])
                    .background(
                    
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                    
                    // Custom Navigation Links...
                    List {
                        
                        CustomNavigationLink(title: "Edit Profile") {
                            
                            Text("")
                                .navigationTitle("Edit Profile")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color("HomeBG").ignoresSafeArea())
                        }
                        
                        
                        CustomNavigationLink(title: "Shopping address") {
                            
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
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [Color.appBlue, .white], startPoint: .top, endPoint: .bottom)
            
//                Color("HomeBG")
                    .ignoresSafeArea()
            )
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
}

struct EZProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        EZProfilePage()
    }
}

