import Foundation
import Capacitor
import FBAudienceNetwork

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(FacebookAds)
public class FacebookAds: CAPPlugin, FBNativeAdDelegate, FBAdViewDelegate {
    var nativeAd: FBNativeAd!
    var adView: FBAdView!
    var adContainer: UIView!
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
    
    @objc func initializeBannerAd(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                let placementId = call.getString("placementId") ?? ""
                
                self.adView = FBAdView.init(placementID: placementId, adSize: kFBAdSizeHeight250Rectangle, rootViewController: rootViewController)
                self.adView.delegate = self;
                self.adView.loadAd()
            }
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
    
    @objc func showBannerAd(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                if (self.adView != nil && self.adView.isAdValid) {
                    rootViewController.view.addSubview(self.adView)
                    rootViewController.view.addConstraints(
                        [NSLayoutConstraint(item: self.adView,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: rootViewController.view.safeAreaInsets.top,
                                            attribute: .top,
                                            multiplier: 1,
                                            constant: CGFloat(0)),
                         NSLayoutConstraint(item: self.adView,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: rootViewController.view,
                                            attribute: .centerX,
                                            multiplier: 1,
                                            constant: 0)
                        ])
                }
            }
        }
    }
    
    @objc func showNativeAd(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            NSLog("Facebook Ads: showing native ad")
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                if (self.nativeAd != nil && self.nativeAd.isAdValid) {
                    self.nativeAd.unregisterView()
                    
                    self.adUIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                    self.adCoverMediaView = FBMediaView()
                    self.iconView = FBMediaView()
                    self.adCallToActionButton = UIButton()
                    self.adTitleLabel = UILabel()
                    self.adBodyLabel = UILabel()
                    self.adSocialContextLabel = UILabel()
                    self.sponsoredLabel = UILabel()
                    self.adOptionsView = FBAdOptionsView()
                    
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
