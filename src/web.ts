import { WebPlugin } from '@capacitor/core';

import type { FCMMultipleProjectPlugin } from './definitions';

export class FCMMultipleProjectWeb
  extends WebPlugin
  implements FCMMultipleProjectPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
