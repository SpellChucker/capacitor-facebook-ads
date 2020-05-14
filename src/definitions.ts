declare module "@capacitor/core" {
  interface PluginRegistry {
    FacebookAds: FacebookAdsPlugin;
  }
}

export interface FacebookAdsPlugin {
  echo(options: { value: string }): Promise<{value: string}>;
  createBanner(options: any): Promise<boolean>;
  initializeNativeAd(options: any): Promise<any>;
  showNativeAd(): Promise<any>;
}
