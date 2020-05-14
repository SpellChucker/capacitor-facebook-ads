import Foundation
import Capacitor
import FBAudienceNetwork

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(FacebookAds)
public class FacebookAds: CAPPlugin, FBNativeAdDelegate {
    var nativeAd: FBNativeAd!
    var adUIView: UIView!
    var adCoverMediaView: FBMediaView!
    var iconView: FBMediaView!
    var adTitleLabel: UILabel!
    var adBodyLabel: UILabel!
    var adSocialContextLabel: UILabel!
    var sponsoredLabel: UILabel!
    var adCallToActionButton: UIButton!
    var adOptionsView: FBAdOptionsView!
    
    @objc func initialize(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            FBAudienceNetworkAds.initialize()
        }
    }
    
    @objc func initializeNativeAd(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let placementId = call.getString("placementId") ?? ""
            
            self.nativeAd = FBNativeAd.init(placementID: placementId)
            self.nativeAd.delegate = self
            self.nativeAd.loadAd()
        }
    }
    
    @objc func showNativeAd(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            NSLog("Facebook Ads: showing native ad")
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                if (self.nativeAd != nil && self.nativeAd.isAdValid) {
                    self.nativeAd.unregisterView()
                    
                    self.adCoverMediaView = FBMediaView()
                    self.iconView = FBMediaView()
                    
                    rootViewController.view.addSubview(self.adUIView)
                    
                    self.nativeAd.registerView(
                        forInteraction: self.adUIView,
                        mediaView: self.adCoverMediaView,
                        iconView: self.iconView,
                        viewController: rootViewController,
                        clickableViews: [self.adCallToActionButton, self.adCoverMediaView]
                    )
                    
                    self.adTitleLabel.text = self.nativeAd.advertiserName;
                    self.adBodyLabel.text = self.nativeAd.bodyText;
                    self.adSocialContextLabel.text = self.nativeAd.socialContext;
                    self.sponsoredLabel.text = self.nativeAd.sponsoredTranslation;
                    self.adCallToActionButton.setTitle(self.nativeAd.callToAction, for: UIControl.State.normal)
                    
                    self.adOptionsView.nativeAd = self.nativeAd;
                }
            }
        }

    }
}
