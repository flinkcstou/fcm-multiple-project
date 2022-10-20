import { registerPlugin } from '@capacitor/core';

import type { FCMMultipleProjectPlugin } from './definitions';

const FCMMultipleProject = registerPlugin<FCMMultipleProjectPlugin>(
  'FCMMultipleProject',
  {
    web: () => import('./web').then(m => {
      return m.FCMMultipleProjectWeb.getInstance();
    }),
  },
);
export * from './multiple/FirebaseConfig';
export * from './multiple/FCMMultipleProjectI';
export * from './definitions';
export { FCMMultipleProject };
