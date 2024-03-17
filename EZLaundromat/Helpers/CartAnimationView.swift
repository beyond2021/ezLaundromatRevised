//
//  CartAnimationView.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/11/24.
//

import SwiftUI

struct CartAnimationView: View {
    var itemsToAddToCart = ["EZMensCoat001", "EZMensSuit2"].shuffled()
    @State var offSetY = -130.0
    @Environment(\.presentationMode) var mode
    @State var remaining = 3.0
    var body: some View {
        ZStack {
            Color.appBlue.ignoresSafeArea(.all)
            ZStack {
                ForEach(1..<100) { index in
                    Image(index % itemsToAddToCart.count == 0 ? itemsToAddToCart[0] : itemsToAddToCart[1])
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: index % 2 == 0 ? 20 : -10, y:offSetY)
                        .animation(Animation.linear(duration: 0.75).delay(TimeInterval(index)),value: offSetY)
                        .opacity(offSetY == -20 ?  0.1 : 1)
                        .animation(Animation.linear(duration: 0.75).delay(TimeInterval(index)),value: offSetY)
                        .opacity(offSetY == -180 ? 0 : 1.0)
                        .animation(Animation.linear(duration: 0.75).delay(TimeInterval(index)),value: offSetY)
                }
                Image(systemName: "cart")
                    .resizable()
                    .tint(.white)
                    .frame(width: 100, height: 100)
                    .tint(.white)
                    
            }
        }
        // Animate the images
        .onAppear {
            withAnimation {
                offSetY = -10
            }
        }
        .onReceive(Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()) { _ in
            
                    self.remaining -= 0.01
                    if self.remaining <= 0 {
                        self.mode.wrappedValue.dismiss()
                    }
                }
    }
}

#Preview {
    CartAnimationView()
}
