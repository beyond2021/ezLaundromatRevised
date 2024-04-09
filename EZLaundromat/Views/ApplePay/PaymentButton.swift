//
//  PaymentButton.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 4/9/24.
//

import SwiftUI
import PassKit

struct PaymentButton: View {
    var action: () -> Void
    var body: some View {
        Respresentable(action: action)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    PaymentButton(action: {})
}
extension PaymentButton {
    struct Respresentable: UIViewRepresentable {
        /// pass an action to this reprsentable same type as the payment button
        var action: () -> Void
        /// Main functions
        func makeCoordinator() -> Coordinator {
            /// pass an action to this coordinator
            Coordinator(action: action)
        }
        func makeUIView(context: Context) -> some UIView {
            context.coordinator.button // View
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
            context.coordinator.action = action // Action
        }
    }
    class Coordinator: NSObject {
        /// 2 arguments
        var action: () -> Void
        var button = PKPaymentButton(
            paymentButtonType: .checkout,
            paymentButtonStyle: .automatic)
        init(action: @escaping () -> Void) {
            self.action = action
            super.init()
            button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
            }
        @objc
        func callback(_ sender: Any) {
            action()
        }
    }
}
