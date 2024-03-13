//
//  PriceList.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/12/24.
//

import SwiftUI

struct PriceList: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Group {
                    Button(action: {}, label: {
                        Text("Request A Pickup")
                            .padding()
                    })
                    .buttonStyle(.borderless)
                    .padding(.top)
                    
                    Text("Laundromat Hours")
                        .font(.title.bold())
                        .padding(.bottom)
                        .foregroundStyle(.red)
                }
                
                
                Group {
                    Text("Monday: 9am – 7pm")
                    Text("Tuesday: 9am – 7pm")
                    Text("Wednesday: 9am – 7pm")
                    Text("Thursday: 9am – 7pm")
                    Text("Friday: 9am – 7pm")
                    Text("Saturday: 10am – 6pm")
                }
                
                Group {
                    Text("Coin Laundry Pricing")
                        .font(.title.bold())
                        .padding(.top)
                        .padding(.bottom)
                        .foregroundStyle(.red)
                    
                }
                Group {
                    Text("• Large 2 Load Washer: $6.50")
                    Text("• Extra-Large 4 Load Washer: $10.25")
                    Text("• Dryers: 25 cents per 2 minutes")
                    
                }
                Group {
                    Button(action: {}, label: {
                        Text("Schedule A Pickup")
                            .padding()
                    })
                    .buttonStyle(.borderless)
                    .padding(.top)
                }
                
            }
                
            }
        }
  }
   


#Preview {
    PriceList()
}
