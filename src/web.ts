import { WebPlugin } from '@capacitor/core';
import { FacebookAdsPlugin } from './definitions';

export class FacebookAdsWeb extends WebPlugin implements FacebookAdsPlugin {
  constructor() {
    super({
      name: 'FacebookAds',
      platforms: ['web']
    });
  }

  async echo(options: { value: string }): Promise<{value: string}> {
    console.log('ECHO', options);
    return options;
  }

  async createBanner(options: any): Promise<boolean> {
    console.log('createBanner', options);
    return options;
  }
}

const FacebookAds = new FacebookAdsWeb();

export { FacebookAds };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(FacebookAds);
