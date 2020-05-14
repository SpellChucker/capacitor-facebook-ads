#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(FacebookAds, "FacebookAds",
           CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(initializeNativeAd, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(showNativeAd, CAPPluginReturnPromise);
)