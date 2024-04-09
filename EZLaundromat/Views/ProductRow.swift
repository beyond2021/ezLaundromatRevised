//
//  ProductRow.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 4/4/24.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var sharedData: EZSharedDataModel
    var product: EZProduct
    @State private var productQuantity: Int = 0
    @State private var productPrice: String = ""
    var body: some View {
        
        VStack {
            HStack(spacing: 20) {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height:  50)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing:  10) {
                        Text(product.title)
                            .foregroundStyle(.primary)
                            .bold()
                        Text("$\(productPrice)")
                            .foregroundStyle(.secondary)
                            .bold()
                    }

                    Spacer()
                    Image(systemName: "trash")
                        .foregroundStyle(Color.red)
                        .onTapGesture {
                            withAnimation {
                            if let index = sharedData.cartProducts.firstIndex(where: { product in
                                return self.product.id == product.id
                            }){
                                // Remove from liked....
                               
                                    sharedData.cartProducts.remove(at: index)
                                }
                            }
                        }
                }
            Stepper("\(productQuantity) \(product.type == "" ? "llbs" : "PIECES")", value: $productQuantity, in: 1...50)
//                .font(.title3.bold())
//                .tint(Color.white)
//                .foregroundStyle(productQuantity == 0 ? .white : .white)
                .foregroundStyle(Color.black)
                .tint(productQuantity == 0 ? Color.appBlue : .red)
                .onChange(of: productQuantity, initial: false) { oldValue, newValue in
                    withAnimation {
                        product.quantity = productQuantity
                        productPrice = sharedData.updatePrice(product.quantity, originalPrice: product.price)
                    }
                    
                }
                .padding(.horizontal, 15)
                .disabled( false)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
    .cornerRadius(10)
    .onAppear{productQuantity = product.quantity}
    }
}

#Preview {
    ProductRow(product: EZProduct(type: .mens, title: "Long Coats and Rain Jackets Cleaned", subtitle: "Eco-Friendly Dry Cleaning", EZProductDescription:  " Most raincoats can be cleaned this way unless they contain polyurethane, which will crack or flake off during the process.", price: "35", productImage: "EZLongCoats", quantity: 1))
}
