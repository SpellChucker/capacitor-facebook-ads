declare module "@capacitor/core" {
  interface PluginRegistry {
    FacebookAds: FacebookAdsPlugin;
  }
}

export interface FacebookAdsPlugin {
  initialize(): Promise<any>;
  initializeBannerAd(options: any): Promise<any>;
  initializeNativeAd(options: any): Promise<any>;
  showBannerAd(): Promise<any>;
  showNativeAd(): Promise<any>;
}
