//
//  iAdsSDK_CMP.swift
//  Adjust
//
//  Created by Trung Nguyễn on 23/10/24.
//

import UIKit
import UserMessagingPlatform


class iAdsSDK_CMP {
    private init() {}
    
    @MainActor
    public static func requestConsent(vc: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        let parameters = UMPRequestParameters()
        parameters.tagForUnderAgeOfConsent = false

        var isCompletionCalled = false

        func safeComplete(_ result: Result<Void, Error>) {
            // Đảm bảo tất cả các luồng đều quay lại hàng đợi chính
            DispatchQueue.main.async {
                guard !isCompletionCalled else { return }
                isCompletionCalled = true
                completion(result)
            }
        }

        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters) { requestConsentError in
            if let consentError = requestConsentError {
                safeComplete(.failure(consentError))
                return
            }

            UMPConsentForm.loadAndPresentIfRequired(from: vc) { loadAndPresentError in
                if let consentError = loadAndPresentError {
                    safeComplete(.failure(consentError))
                    return
                }

                if UMPConsentInformation.sharedInstance.canRequestAds {
                    safeComplete(.success(()))
                }
            }
        }

        if UMPConsentInformation.sharedInstance.canRequestAds {
            safeComplete(.success(()))
        }
    }
}

