//
//  PaymentHandler.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.06.24.
//

import Foundation
import PassKit

extension CustomerView {
    typealias PaymentCompletionHandler = (Bool) -> Void
    
    @Observable
    class PaymentHandler: NSObject {
        var paymentController: PKPaymentAuthorizationController?
        var paymentSummaryItems = [PKPaymentSummaryItem]()
        var paymentStatus = PKPaymentAuthorizationStatus.failure
        var completionHandler: PaymentCompletionHandler?
        
        static let supportedNetworks: [PKPaymentNetwork] = [
            .visa,
            .masterCard
        ]
        
        func shippingMethodCalculator() -> [PKShippingMethod] {
            let today = Date.now
            let calendar = Calendar.current
            
            let shippingStart = calendar.date(byAdding: .day, value: 5, to: today)
            let shippingEnd = calendar.date(byAdding: .day, value: 10, to: today)
            
            if let shippingEnd, let shippingStart {
                let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
                let endComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)
                
                let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
                shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
                shippingDelivery.detail = "Sweaters sent to your address"
                shippingDelivery.identifier = "DELIVERY"
                
                return [shippingDelivery]
            }
            
            return []
        }
        
        func startPayment(products: [Product], total: Int, completion: @escaping PaymentCompletionHandler) {
            completionHandler = completion
            
            paymentSummaryItems = []
            
            products.forEach { product in
                let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(string: "\(product.price)"), type: .final)
                paymentSummaryItems.append(item)
            }
            
            let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total)"), type: .final)
            paymentSummaryItems.append(total)
            
            let paymentRequest = PKPaymentRequest()
            paymentRequest.paymentSummaryItems = paymentSummaryItems
            paymentRequest.merchantIdentifier = "merchant.com.github.AdnanBox.ShopAtTBE"
            paymentRequest.merchantCapabilities = .threeDSecure
            paymentRequest.countryCode = "AE"
            paymentRequest.currencyCode = "AED"
            paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
            paymentRequest.shippingType = .delivery
            paymentRequest.shippingMethods = shippingMethodCalculator()
            paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
            
            paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
            paymentController?.delegate = self
            paymentController?.present(completion: { (presented: Bool) in
                if presented {
                    debugPrint("Presented payment controller")
                } else {
                    debugPrint("Failed to present payment controller")
                }
            })
        }
    }
}

extension CustomerView.PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    
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
