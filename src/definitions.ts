declare module "@capacitor/core" {
  interface PluginRegistry {
    FacebookAds: FacebookAdsPlugin;
  }
}

export interface FacebookAdsPlugin {
  initialize(): Promise<any>;
  createBanner(options: any): Promise<boolean>;
  initializeNativeAd(options: any): Promise<any>;
  showNativeAd(): Promise<any>;
}
