import type { Messaging } from '@firebase/messaging';
import type { FirebaseApp, FirebaseOptions } from 'firebase/app';

import type { FirebaseConfig } from './FirebaseConfig';


export interface FCMMultipleProjectI {
  test(): void;

  init(): void;

  add(firebaseConfig: FirebaseConfig): void;

  clean(): void;

  remove(firebaseConfig: FirebaseConfig): void;

  getToken(firebaseConfig: FirebaseConfig, apply: (value: any) => void, reject: (value: any) => void): void;

  getDefaultInstance(): FirebaseApp;

  getInstance(firebaseAppName: string): FirebaseApp;

  getFirebaseMessaging(firebaseConfig: FirebaseConfig): Messaging;

  createFirebaseConfig(obj: any): FirebaseConfig;

  hasRights(firebaseConfig: FirebaseConfig, apply: (value: any) => void, reject: (value: any) => void): void;

  initializeApp(firebaseConfig: FirebaseConfig): FirebaseApp;

  createFirebaseOptions(firebaseConfig: FirebaseConfig): FirebaseOptions;
}
