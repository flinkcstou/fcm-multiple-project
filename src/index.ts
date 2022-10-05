import { registerPlugin } from '@capacitor/core';

import type { FCMMultipleProjectPlugin } from './definitions';

const FCMMultipleProject = registerPlugin<FCMMultipleProjectPlugin>(
  'FCMMultipleProject',
  {
    web: () => import('./web').then(m => new m.FCMMultipleProjectWeb()),
  },
);

export * from './definitions';
export { FCMMultipleProject };
