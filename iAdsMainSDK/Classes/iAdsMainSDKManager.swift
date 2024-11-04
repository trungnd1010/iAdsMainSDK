import iAdsSDK
import iAdsCoreSDK

#if canImport(iAdsAdmobSDK)
import iAdsAdmobSDK
#endif

#if canImport(iAdsMaxSDK)
import iAdsMaxSDK
#endif

public class iAdsMainSDKManager {
    
    public static let shared = iAdsMainSDKManager()
    private init() {}
    
    @MainActor public func setup(isTestAds: Bool) {
        
        var interManager: [AdsName : iAdsCoreSDK_IntertitialProtocol.Type] = [:]
        var openManager: [AdsName : iAdsCoreSDK_OpenProtocol.Type] = [:]
        var rewardedManager: [AdsName : iAdsCoreSDK_RewardedProtocol.Type] = [:]
        let bannerManager: [AdsName : iAdsCoreSDK_BannerProtocol.Type] = [:]
        var nativeManager: [AdsName : iAdsCoreSDK_NativeProtocol.Type] = [:]
        
        #if canImport(iAdsAdmobSDK)
        interManager[AdsName.ads_mod] = iAdsAdmobSDK_InterManager.self
        openManager[AdsName.ads_mod] = iAdsAdmobSDK_OpenManager.self
        rewardedManager[AdsName.ads_mod] = iAdsAdmobSDK_RewardedManager.self
//        bannerManager[AdsName.ads_mod] = iadmo
        nativeManager[AdsName.ads_mod] = iAdsAdmobSDK_NativeManager.self
        
        interManager[AdsName.ads_gam] = iAdsGamSDK_InterManager.self
        openManager[AdsName.ads_gam] = iAdsGamSDK_OpenManager.self
        rewardedManager[AdsName.ads_gam] = iAdsGamSDK_RewardedManager.self
//        bannerManager[AdsName.ads_mod] = iadsgam
        nativeManager[AdsName.ads_gam] = iAdsGamSDK_NativeManager.self
        #endif
        
        #if canImport(iAdsMaxSDK)
        interManager[AdsName.ads_max] = iAdsMaxSDK_InterManager.self
        openManager[AdsName.ads_max] = iAdsMaxSDK_OpenManager.self
        rewardedManager[AdsName.ads_max] = iAdsMaxSDK_RewardedManager.self
//        bannerManager[AdsName.ads_mod] = iadmo
        nativeManager[AdsName.ads_max] = iAdsMaxSDK_NativeManager.self
        #endif
        
        iAdsSDKManager.shared.setup(isTestAds: isTestAds,
                                    interManager: interManager,
                                    openManager: openManager,
                                    rewardedManager: rewardedManager,
                                    bannerManager: bannerManager,
                                    nativeManager: nativeManager)
        
    #if canImport(iAdsAdmobSDK)
        iAdsAdmobSDKManager.shared.setup(isTestAds: isTestAds)
    #endif
        
    #if canImport(iAdsMaxSDK)
        iAdsMaxSDKManager.shared.setup(sdkKey: iAdsSDKManager.shared.maxKey, isTestAds: isTestAds)
    #endif
    }
    
    public func getData(vc: UIViewController,
                        completionLoadAds: @escaping (Result<Void, Error>) -> Void,
                        completionCMP: @escaping (Result<Void, Error>) -> Void) {
        
        DispatchQueue.main.async {
            iAdsSDK_CMP.requestConsent(vc: vc) { result in
                completionCMP(result)
            }
        }
        
        iAdsSDKManager.shared.getData(vc: vc) { result in
            completionLoadAds(result)
        }
    }
    
    @MainActor
    public func showAdsStart(completion: @escaping (Result<Void, Error>) -> Void) {
        iAdsSDKManager.shared.showAdsStart(completion: completion)
    }
    
    @MainActor
    public func showAdsFull(vc: UIViewController,
                            screenName: String,
                            completion: @escaping (Result<Void, Error>) -> Void) {
        iAdsSDKManager.shared.showAdsFull(vc: vc,
                                          screenName: screenName,
                                          completion: completion)
    }
    
    @MainActor
    public func showAdsWidget(containerView: UIView,
                              nativeAdmobView: UIView,
                              nativeMaxView: UIView,
                              screenName: String,
                              completion: @escaping (Result<Void, Error>) -> Void) {
        iAdsSDKManager.shared.showAdsWidget(containerView: containerView,
                                            nativeAdmobView: nativeAdmobView,
                                            nativeMaxView: nativeMaxView,
                                            screenName: screenName,
                                            completion: completion)
    }
    
    public func setIsCanShowAdsOpenResume(_ isCanShow: Bool) {
        iAdsSDKManager.shared.isCanShowAdsResume = isCanShow
    }
    
    public func setIsCanShowAds(_ isCanShow: Bool) {
        iAdsSDKManager.shared.isCanShowAds = isCanShow
    }
    
    public func isCanShowAdsFull(screenName: String) -> Bool {
        return iAdsSDKManager.shared.isCanShowAdsFull(screenName: screenName)
    }
    
    public func isCanshowAdsWidget(screenName: String) -> Bool {
        return iAdsSDKManager.shared.isCanshowAdsWidget(screenName: screenName)
    }
    
    public func preLoadOpenAds(screenName: String?,
                               completion: ((Result<Void, Error>) -> Void)?) {
        return iAdsSDKManager.shared.preLoadOpenAds(screenName: screenName,
                                                    completion: completion)
    }
    
    public func preLoadInterAds(screenName: String?,
                                completion: ((Result<Void, Error>) -> Void)?) {
        iAdsSDKManager.shared.preLoadInterAds(screenName: screenName,
                                              completion: completion)
    }
    
    public func preLoadRewardedAds(screenName: String?,
                                   completion: ((Result<Void, Error>) -> Void)?) {
        iAdsSDKManager.shared.preLoadRewardedAds(screenName: screenName,
                                                 completion: completion)
    }
    
    public func preLoadNativeAds(screenName: String?,
                                 completion: ((Result<Void, Error>) -> Void)?) {
        iAdsSDKManager.shared.preLoadNativeAds(screenName: screenName,
                                               completion: completion)
    }
}
