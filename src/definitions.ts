import type { PluginListenerHandle } from '@capacitor/core';

import type { FirebaseConfig, FirebaseToken, FirebaseTokenError } from './multiple/FirebaseConfig';


export interface FCMMultipleProjectPlugin {

  echo(options: { value: string }): Promise<{ value: string }>;

  add(firebaseConfig: FirebaseConfig): Promise<void>;

  addListener(eventName: 'multipleToken', listenerFunc: (token: FirebaseToken) => void): Promise<PluginListenerHandle> & PluginListenerHandle;

  addListener(eventName: 'multipleTokenError', listenerFunc: (error: FirebaseTokenError) => void): Promise<PluginListenerHandle> & PluginListenerHandle;

  removeAllListeners(): Promise<void>;

  clean(): Promise<void>;

}
