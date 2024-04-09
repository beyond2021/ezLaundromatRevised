//
//  PaymentHandler.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 4/9/24.
//

import Foundation
import PassKit

/// Insteadt or always writing  (Bool) -> Void   we just write PaymentCompletionHandler
typealias PaymentCompletionHandler = (Bool) -> Void
class PaymentHandler: NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]() /// initializing an empty array of PK will hold everything inside the cart
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    /// Supported Networks
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa,
        .masterCard,
        .amex
    ]
    func shippingMethodCalculator() -> [PKShippingMethod] {
        /// Calulating delivery time
        let today = Date()
        /// Create the callendar
        let calendar = Calendar.current
        
        /// Adding 7 days to ship from today
        let shippingStart = calendar.date(byAdding: .day, value: 7, to: today) //optional
        let shippingEnd = calendar.date(byAdding: .day, value: 10, to: today) // optional
        /// Unwrapping the Optionals
        if let shippingStart = shippingStart, let shippingEnd = shippingEnd {
            //Set startComponents if not nil
            let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)///date from start date
            // Set endComponents if not nil
            let endComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)///date from endt date
            let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))/// free shipping
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDelivery.detail = "Laundry is delivered to your address."
            shippingDelivery.identifier = "DELIVERY"
            return [shippingDelivery]
        }
        /// unwrap above fails
        return []
    }
    func startPayment(products: [EZProduct], total: Double, completion: @escaping PaymentCompletionHandler) {
        // PaymentCompletionHandler) runs when the function is finished running
        //1: set completion handler above to the one passed in
        completionHandler = completion
        // RESET our payment summary items
        paymentSummaryItems = []
        // Iterate over products array
        products.forEach { product in
            let item = PKPaymentSummaryItem(label: product.title, amount: NSDecimalNumber(string: "\(product.price).00"), type: .final)
            paymentSummaryItems.append(item)
        }
        
        let total = PKPaymentSummaryItem(label:"Total", amount: NSDecimalNumber(string: "\(total).00"), type: .final)
        paymentSummaryItems.append(total)
        
        //Create a payment Request
        let paymentRequest = PKPaymentRequest()
        /// information for user's order
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.beyond2021.EZLaundromat"
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.countryCode = "US" 
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        paymentRequest.shippingType = .delivery
        paymentRequest.shippingMethods = shippingMethodCalculator()
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress, .phoneNumber]
        
        //Showing the Sheet
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        //Present The sheet UIKit
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                debugPrint("Prsented payment controller")
            } else {
                debugPrint("Failed to prsented payment controller")
            }
        })
        
        
        
    }
}
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    /// success and errors related to the payment
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    /// Dismiss the ship presentaion
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    if let completionHandler = self.completionHandler {
                        completionHandler(true)
                    }
                    
                } else {
                    if let completionHandler = self.completionHandler {
                        completionHandler(false)
                    }
                }
            }
        }
    }
   
}
