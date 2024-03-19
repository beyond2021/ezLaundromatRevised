//
//  PriceList.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/12/24.
//

import SwiftUI

struct PriceList: View {
    @Environment(\.presentationMode) var mode
    var body: some View {
        ScrollView {
            VStack( spacing: 5) {
                Group {
                    Button(action: {}, label: {
                        Text("Request A Pickup")
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
                    .padding(.top, 40)
                    
                    Text("LAUNDRY HOURS")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(6.0)
                        //
                }
                .padding(.bottom)
                
                
                Group {
                    Text("Monday: 9am – 7pm")
                    Text("Tuesday: 9am – 7pm")
                    Text("Wednesday: 9am – 7pm")
                    Text("Thursday: 9am – 7pm")
                    Text("Friday: 9am – 7pm")
                    Text("Saturday: 10am – 6pm")
                }
                .font(.callout.bold())
//                .padding(.bottom)
                
                Group {
                    Text("COIN LAUNDRY PRICES")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(6.0)

                    
                }
                .padding(.top)
               
                    Text("• Large 2 Load Washer: $6.50")
                    Text("• Extra-Large 4 Load Washer: $10.25")
                    Text("• Dryers: 25 cents per 2 minutes")
                    
               
                Group {
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
                }
                
            }
            .overlay(alignment: .topTrailing, content: {
                Button("Close") {
                    self.mode.wrappedValue.dismiss()
                }
                .padding(15)
            })
            
            
                
            }
        
        }
  }
   


#Preview {
    PriceList()
}
